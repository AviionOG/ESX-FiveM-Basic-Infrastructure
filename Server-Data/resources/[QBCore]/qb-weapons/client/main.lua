ESX = nil

local isLoggedIn = true
local CurrentWeaponData = {}
local PlayerData = {}
local CanShoot = true

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	ClearDrawOrigin()
end

 


Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports['es_extended']:getSharedObject()
        Citizen.Wait(3)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function() 
    while true do
        if isLoggedIn then
            TriggerServerEvent("weapons:server:SaveWeaponAmmo")
        end
        Citizen.Wait(60000)
    end
end)



local MultiplierAmount = 0

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if isLoggedIn then
            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                if CurrentWeaponData == GetHashKey("weapon_flashlight") then
                    return
                end

                if IsPedShooting(PlayerPedId()) or IsControlJustPressed(0, 24) then
                    sleep = 2
                    if CanShoot then
                        local weapon = GetSelectedPedWeapon(PlayerPedId())
                        local ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
                       -- if ESX.GetWeaponList[weapon]["name"] == "weapon_snowball" then
                        --    TriggerServerEvent('QBCore:Server:RemoveItem', "snowball", 1)
                        --else
                            if ammo >= 0 then
                                MultiplierAmount = MultiplierAmount + 1
                            end
                        --end
                    else
                        TriggerEvent('inventory:client:CheckWeapon')
                        ESX.Notify("Başarısız","Bu silah kullanılamaz",3000,"error")
                        MultiplierAmount = 0
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local player = PlayerId()
        local weapon = GetSelectedPedWeapon(ped)
        local ammo = GetAmmoInPedWeapon(ped, weapon)

        if ammo == 1 then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            if IsPedInAnyVehicle(ped, true) then
                SetPlayerCanDoDriveBy(player, false)
            end
        else
            EnableControlAction(0, 24, true) -- Attack
			EnableControlAction(0, 257, true) -- Attack 2
            if IsPedInAnyVehicle(ped, true) then
                SetPlayerCanDoDriveBy(player, true)
            end
        end

        if IsPedShooting(ped) then
            if ammo - 1 < 1 then
                SetAmmoInClip(PlayerPedId(), GetHashKey(Config.Weapons[weapon]["name"]), 1)
            end
        end
        
        Citizen.Wait(0)
    end
end)

-- RegisterCommand("hudkapa", function()
--     while true do
--         Citizen.Wait(0)
--         DisplayHud(false)
--     end
-- end)


Citizen.CreateThread(function()
    while true do
        local weapon = GetSelectedPedWeapon(PlayerPedId())
        local wait = 500
        if weapon ~= -1569615261 then
            wait = 250
            local ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
            if ammo > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
            else
                TriggerEvent('inventory:client:CheckWeapon')
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, 0)
            end

            if MultiplierAmount > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                MultiplierAmount = 0
            end
        end
        Citizen.Wait(wait)
    end
end)

local using = false
RegisterNetEvent('weapon:client:AddAmmo')
AddEventHandler('weapon:client:AddAmmo', function(type, amount, itemData)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if CurrentWeaponData ~= nil then
        if using then 
            return
        end
            
        if Config.Weapons[weapon]["name"] ~= "weapon_unarmed" and Config.Weapons[weapon]["ammotype"] == type:upper() then
            local total = (GetAmmoInPedWeapon(PlayerPedId(), weapon))
          --  local Skillbar = exports['qb-skillbar']:GetSkillbarObject()

            if total <= 200 then
            --    QBCore.Functions.Progressbar("taking_bullets", "Şarjor Değiştiriliyor..", math.random(4000, 6000), false, true, {
              --      disableMovement = false,
                --    disableCarMovement = false,
                --    disableMouse = false,
                --    disableCombat = true,
               -- }, {}, {}, {}, function() -- Done
                
                    pressed = true
                    if Config.Weapons[weapon] ~= nil then
                        using = true
                            using = false
                            -- TriggerEvent("mythic_progbar:client:progress", {
                            --     name = "arüüm",
                            --     duration = 6000,
                            --     label = "Mermi Dolduruyorsun...",
                            --     useWhileDead = false,
                            --     canCancel = true,
                            --     controlDisables = {
                            --     disableMovement = false,
                            --     disableCarMovement = false,
                            --     disableMouse = false,
                            --     disableCombat = false,
                            --   },
                            --   animation = {
                            --     animDict = "missheistdockssetup1clipboard@idle_a",
                            --     anim = "idle_a",
                            -- },
                            -- prop = {
                            --     model = "prop_paper_bag_small",
                            -- },
                            --   }, function(status)
                            --     if not status then
                            --     end
                            -- end)
                        using = false
                            SetAmmoInClip(ped, weapon, 0)
                            SetPedAmmo(ped, weapon, total + 30)
                            TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + 30)
                            TriggerServerEvent('removefalanfilan', itemData.name, 1, itemData.slot)
                    end
                    pressed = false
            else
                pressed = false
                ESX.Notify("Başarısız","Yeterince Mermin VAR!",3000,"error")
            end
        else
            pressed = false
            ESX.Notify("Başarısız","Silahın yok veya bu mermi bu silaha uygun değil!",3000,"error")
        end
    else
        pressed = false
        ESX.Notify("Başarısız","Silahın Yok",3000,"error")
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent("weapons:server:LoadWeaponAmmo")
    isLoggedIn = true
    PlayerData = ESX.GetPlayerData()

    ESX.TriggerServerCallback("weapons:server:GetConfig", function(RepairPoints)
        for k, data in pairs(RepairPoints) do
            Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
            Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
        end
    end)
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon')
AddEventHandler('weapons:client:SetCurrentWeapon', function(data, bool)
    if data ~= false then
        CurrentWeaponData = data
    else
        CurrentWeaponData = {}
    end
    CanShoot = bool
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false

    for k, v in pairs(Config.WeaponRepairPoints) do
        Config.WeaponRepairPoints[k].IsRepairing = false
        Config.WeaponRepairPoints[k].RepairingData = {}
    end
end)

RegisterNetEvent('weapons:client:SetWeaponQuality')
AddEventHandler('weapons:client:SetWeaponQuality', function(amount)
    if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
        TriggerServerEvent("weapons:server:SetWeaponQuality", CurrentWeaponData, amount + 0.0)
    end
end)

Citizen.CreateThread(function()
    while true do
            local wait = 2250
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = GetDistanceBetweenCoords(pos, data.coords.x, data.coords.y, data.coords.z, true)

                if distance < 10 then
                    wait = 3

                    if distance < 1 then
                        wait = 3
                        if data.IsRepairing then
                            if data.RepairingData.identifier ~= PlayerData.identifier then
                                DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Tamirhane ~r~Mesgul~w~')
                            else
                                if not data.RepairingData.Ready then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Silahın Tamir Ediliyor')
                                else
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'E - Geri Al')
                                end
                            end
                        else
                            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                                if not data.RepairingData.Ready then
                                    local WeaponData = Config.Weapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '~b~E~w~ - Silah Onar, ~g~$'..Config.WeaponRepairCotsts[WeaponClass]..'~w~')
                                    if IsControlJustPressed(1, 38) then
                                        ESX.TriggerServerCallback('weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                else
                                    if data.RepairingData.identifier ~= PlayerData.identifier then
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Tamirhane Aktif Degil')
                                    else
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'E - Geri Al')
                                        if IsControlJustPressed(1,38) then
                                            TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.identifier == nil then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Elinde Silah Yok')
                                elseif data.RepairingData.identifier == PlayerData.identifier then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'E - Geri Al')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Citizen.Wait(wait)
    end
end)

RegisterNetEvent("weapons:client:SyncRepairShops")
AddEventHandler("weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)

RegisterNetEvent("weapons:client:EquipAttachment")
AddEventHandler("weapons:client:EquipAttachment", function(ItemData, attachment)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = Config.Weapons[weapon]
    
    if weapon ~= GetHashKey("WEAPON_UNARMED") then
        WeaponData.name = WeaponData.name:upper()
        if Config.WeaponAttachments[WeaponData.name] ~= nil then
            if Config.WeaponAttachments[WeaponData.name][attachment] ~= nil then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, Config.WeaponAttachments[WeaponData.name][attachment])
            else
                ESX.Notify("Başarısız","Bu Silah bu parçayı desteklemiyor!",3000,"error")
            end
        end
    else
        ESX.Notify("Başarısız","Elinde Silah Yok!",3000,"error")
    end
end)

RegisterNetEvent("addAttachment")
AddEventHandler("addAttachment", function(component)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = Config.Weapons[weapon]
    GiveWeaponComponentToPed(ped, GetHashKey(WeaponData.name), GetHashKey(component))
end)


local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

RandomStr = function(length)
	if length > 0 then
		return RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

RandomInt = function(length)
	if length > 0 then
		return RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

SplitStr = function(str, delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( str, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( str, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( str, delimiter, from  )
	end
	table.insert( result, string.sub( str, from  ) )
	return result
end