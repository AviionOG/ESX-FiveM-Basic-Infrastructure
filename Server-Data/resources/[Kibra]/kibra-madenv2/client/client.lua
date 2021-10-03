ESX = nil

local kaziyomu = false 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
while true do 
    Wait(0)
    local ped = PlayerPedId()
    local kordnt = GetEntityCoords(ped)
    for k,v in pairs(Config.MadenArac) do 
        local dist = #(kordnt - v)
        if dist < 1 then
            if IsControlJustPressed(0, 38) then 
                aracSend()
            end
            DrawMarker(36, v.x, v.y, v.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.6, 255, 255, 255, 100, false, true, 1, nil, nil, false)
            if Config.NotifyText then 
            DrawText3D(v.x, v.y, v.z + 0.2, '~g~E~s~ - Arac Cıkar')
            else 
            ESX.ShowHelpNotification("~INPUT_CONTEXT~ - Arac Çıkar")
            end
         end
    end
end
end)

Citizen.CreateThread(function()
while true do 
    Wait(0)
    local ped = PlayerPedId()
    local kordnt = GetEntityCoords(ped)
    for k,v in pairs(Config.AracSil) do 
        local dist1 = #(kordnt - v)
        if dist1 < 1.5 then 
            if IsControlJustPressed(0, 38) then 
                aracparaver()
            end
                DrawMarker(20, v.x, v.y, v.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.6, 255, 255, 255, 100, false, true, 1, nil, nil, false)
            if Config.NotifyText then 
            DrawText3D(v.x, v.y, v.z + 0.2, '~g~E~s~ - Aracı geri ver')
            else 
            ESX.ShowHelpNotification("~INPUT_CONTEXT~ - Aracı geri ver")
            end
        end
    end 
end 
     
end)

Citizen.CreateThread(function()
while true do
    Wait(0)
    local ped = PlayerPedId()
    local kordnt = GetEntityCoords(ped)
    for k,v in pairs(Config.Toplama) do 
        local disttopla = #(kordnt - v)
        if disttopla < 1 then 
            if IsControlJustPressed(0, 38) then 
                TriggerServerEvent("kibra-madenv2:kazmaKontrol1")
            end
        DrawMarker(20, v.x, v.y, v.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.6, 255, 255, 255, 100, false, true, 1, nil, nil, false)
         if Config.NotifyText then 
         DrawText3D(v.x, v.y, v.z + 0.2, '~g~E~s~ - Tas Kaz')
         else 
        ESX.ShowHelpNotification("~INPUT_CONTEXT~ - Taş Kaz")
        end
        end
    end
end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local kordnt = GetEntityCoords(ped)
        for k,v in pairs(Config.Isleme) do 
            local disttopla1 = #(kordnt - v)
            if disttopla1 < 1 then 
                if IsControlJustPressed(0, 38) then 
                    isleLan()
                end
            DrawMarker(20, v.x, v.y, v.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.6, 255, 255, 255, 100, false, true, 1, nil, nil, false)
             if Config.NotifyText then 
             DrawText3D(v.x, v.y, v.z + 0.2, '~g~E~s~ - Tas Isle')
             else 
            ESX.ShowHelpNotification("~INPUT_CONTEXT~ - Taş İşle")
            end
            end
        end
    end
    end)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            local ped = PlayerPedId()
            local kordnt = GetEntityCoords(ped)
            for k,v in pairs(Config.Satis) do 
                local disttopla11 = #(kordnt - v)
                if disttopla11 < 1 then 
                    if IsControlJustPressed(0, 38) then 
                       OpenMenu()
                    end
                DrawMarker(20, v.x, v.y, v.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.6, 255, 255, 255, 100, false, true, 1, nil, nil, false)
                 if Config.NotifyText then 
                 DrawText3D(v.x, v.y, v.z + 0.2, '~g~E~s~ - Sat')
                 else 
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ - Sat")
                end
                end
            end
        end
        end)



 RegisterNetEvent("kibra-madenv2:kzln")
 AddEventHandler("kibra-madenv2:kzln", function()
 KazLan()
end)
KazLan = function() 
    local kazknk = exports["reload-skillbar"]:taskBar(5000,math.random(1,4))
    TriggerEvent("mythic_progbar:client:progress", {
        name = "kayakaz",
        duration = 10000,
        label = "Taş kazıyorsun",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "melee@large_wpn@streamed_core",
            anim = "ground_attack_on_spot",
            flags = 49,
        },
        prop = {
            model = "prop_tool_pickaxe",
            bone = 57005,
            coords = { x = 0.18, y = -0.02, z = -0.02 },
            rotation = { x = 100.0, y = 150.00, z = 140.0 },
        },
    }, function(status)
        if not status then
            TriggerServerEvent("kibra-madenv2:topla")
        end
    end)
end

isleLan = function() 
    local kazknk = exports["reload-skillbar"]:taskBar(5000,math.random(1,4))
    TriggerEvent("mythic_progbar:client:progress", {
        name = "kayakaz",
        duration = 10000,
        label = "Taş işliyorsunuz",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@prop_human_bum_bin@idle_a",
            anim = "idle_a",
            flags = 49,
        },
       
    }, function(status)
        if not status then
            TriggerServerEvent("kibra-madenv2:Isle")
        end
    end)
end

satLan = function() 
    TriggerEvent("mythic_progbar:client:progress", {
        name = "kayakaz",
        duration = 10000,
        label = "Taşlar kontrol ediliyor",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
       
    }, function(status)
        if not status then
            TriggerServerEvent("kibra-madenv2:Sat")
        end
    end)
end

function OpenMenu()

	local elements = {
		{label = "Eritilmiş Taş "..Config.KacPara..'$', value = 'eritilmis'},
        
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'KibraDevWorks', {
		title    = "Maden Satış",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'eritilmis' then
			satLan()
		end
	end, function(data, menu)
		menu.close()
	end)

end


RegisterNetEvent('kibra-madenv2:aracVer')
AddEventHandler('kibra-madenv2:aracVer', function ()
    if vehicle == nil then
        local modelHash = GetHashKey(Config.AracModel)
        RequestModel(Config.AracModel)
        local isLoaded = HasModelLoaded(Config.AracModel)
        while isLoaded == false do
            Citizen.Wait(1000)
        end
        
        vehicle = CreateVehicle(Config.AracModel, Config.AracSpawn, 145.50, 1, 0)
        local props = ESX.Game.GetVehicleProperties(vehicle)
        props.plate = 'Kibra  ' .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9)   
        exports['swt_notifications']:Success("Madencilik","Aracınız oluşturuldu","top",2000,true)
    else
        exports['swt_notifications']:Negative("Madencilik","Zaten aracınız var","top",2000,true)
    end
end)

function aracSend()
    if vehicle == nil then
        TriggerServerEvent('kibra-madenv2:aracGonder')
    else
        exports['swt_notifications']:Negative("Madencilik","Zaten aracınız var","top",2000,true)
    end
end

function aracparaver()
    if vehicle ~= nil then
            DeleteEntity(vehicle)
            DeleteVehicle(vehicle)
            ESX.Game.DeleteVehicle(vehicle)
            vehicle = nil
            exports['swt_notifications']:Success("Madencilik","Aracınız silindi","top",2000,true)
            TriggerServerEvent('kibra-madenv2:verPara')
        else
            exports['swt_notifications']:Info("Madencilik","Binip Tekrar Deneyin","top",2000,true)
        end
    
end

  Citizen.CreateThread(function()
    for k,v in pairs(Config.Blip) do
    local blip = AddBlipForCoord(v.kordinat)
    SetBlipSprite(blip, 171)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 46)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.blipname)
    EndTextCommandSetBlipName(blip)
    end
end)

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
