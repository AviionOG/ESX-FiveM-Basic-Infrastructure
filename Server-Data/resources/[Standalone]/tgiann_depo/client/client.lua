ESX = nil
local coreLoaded = false
local depoKordinat = vector3(-260.50, -2657.1, 6.42847)


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true

    local blip = AddBlipForCoord(depoKordinat)
    SetBlipSprite(blip, 473)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 41)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Depo")
    EndTextCommandSetBlipName(blip)

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    firstLogin()
end)

RegisterNetEvent('tgiann-depo:yenile')
AddEventHandler('tgiann-depo:yenile', function()
    depoAc()
end)

function firstLogin()
    PlayerData = ESX.GetPlayerData()
end



function depoAc()
    ESX.TriggerServerCallback("tgiann:depo:server:readSQL", function(data)
        SendNUIMessage({type = "open", data = data, identifier = PlayerData.identifier})
        SetNuiFocus(true, true)
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        SetNuiFocus(false, false)
    end
end)

RegisterNUICallback('kapat', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('satinal', function(data, cb)
    ESX.TriggerServerCallback('tgiann:depo:writesql', function(data)
	end, data)
end)
    
RegisterNUICallback('deposat', function(data, cb)
    TriggerServerEvent("tgiann:depo:server:sat")
    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Depo Silindi!'})
end)

RegisterNUICallback('ac', function(data, cb)
    TriggerEvent("inventory:client:SetCurrentStash", "Depo_" ..data.ad)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Depo_" ..data.ad, {
        maxweight = 10000000,
        slots = 140,
    })
end)


RegisterNetEvent('just_stash:client:paramyok')
AddEventHandler('just_stash:client:paramyok', function()
    print('parayok')
    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Üzerinde $5000 yok'})
end)

RegisterNUICallback('sifreyanlis', function()
    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Girilen Şifre Yanlış!'})
end)

Citizen.CreateThread(function()
	while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local mesafe = #(depoKordinat - coords)
        if mesafe < 20 and coreLoaded then
            time = 1
            DrawMarker(2, depoKordinat.x, depoKordinat.y, depoKordinat.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 0, 0, 200, false, true, false, false, false, false, false)
            if mesafe < 3 then
                local yazi = ""
                if mesafe < 1 then
                    yazi = "[E] "
                    if IsControlJustReleased(0, 38) then
                        depoAc()
                    end
                end
                DrawText3D(depoKordinat.x, depoKordinat.y, depoKordinat.z-0.35, yazi.."Kiralık Depo")
            end
        end
        Citizen.Wait(time)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 245)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 410
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 133)
end

