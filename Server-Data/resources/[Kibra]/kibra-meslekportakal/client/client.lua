Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local ped = PlayerPedId()
local satisnpc = {x = 148.381, y = 1670.81, z = 227.656}
local portakaldami = false
local blips = vector3(369.815, 6531.45, 28.3881)
local baslangicblip = vector3(-389.23, 6050.52, 31.5001)
local baslangic = {vector3(-389.23, 6050.52, 31.5001)}
local satis = {vector3(148.381, 1670.81, 228.656)}
local satisblip = vector3(148.381, 1670.81, 228.656)
local araccikar = {vector3(-387.21, 6054.60, 31.5001)}
local aracyer = vector3(-400.16, 6048.00, 31.5001)
local aracsil = {vector3(-394.57, 6061.56, 31.0833)}
local agaclar = 
   { 
       vector3(369.815, 6531.45, 28.3881),
       vector3(362.024, 6531.32, 28.3490),
       vector3(354.370, 6530.79, 28.3533),
       vector3(346.494, 6531.22, 28.6813),
       vector3(339.207, 6531.26, 28.5687),
       vector3(330.039, 6531.08, 28.5847),
       vector3(322.411, 6531.04, 29.1244),
       vector3(329.809, 6518.08, 28.9626),
       vector3(338.301, 6517.03, 28.9466),
       vector3(347.633, 6518.17, 28.7866),
       vector3(354.835, 6517.34, 28.2294),
       vector3(361.994, 6517.86, 28.2678)
   }

local markerSize   = {x = 1.5, y = 1.5, z = 1.0}

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
 		local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(ped), false, nil, true

		for k,v in pairs(agaclar) do
			local distance = #(playerCoords - v)

			if distance < 1.5 then
				letSleep = false
                if not portakaldami then 
                else 
               DrawText3D(v.x, v.y, v.z + 0.5, '~g~E~s~ - Portakal Topla')
              if IsControlJustReleased(0, 38) then
                kibraPrtklTopla()
              end
              end
				if distance < markerSize.x then
					isInMarker, currentZone = true, k
				end
			end
        end
    end
	end)

    Citizen.CreateThread(function()
        RequestModel(GetHashKey("a_m_y_bevhills_01"))
        while not HasModelLoaded(GetHashKey("a_m_y_bevhills_01")) do
            Wait(1000)
        end
        npc = CreatePed(1, GetHashKey("a_m_y_bevhills_01"), satisnpc.x, satisnpc.y, satisnpc.z, 172.25, false, true)
        SetPedCombatAttributes(npc, 46, true)               
        SetPedFleeAttributes(npc, 0, 0)               
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
    end)

    Citizen.CreateThread(function()
        while true do
            local sleep = 7
             local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(ped), false, nil, true
    
            for k,v in pairs(baslangic) do
                local distance = #(playerCoords - v)
    
                if distance < 1 then
                    letSleep = false
                    sleep = 2
                    if portakaldami == false then 
                    DrawText3D(v.x, v.y, v.z + 0.5, '~g~E~s~ - Portakal Basla')
                    if IsControlJustReleased(0, 38) then
                    gir()
                    end
                    else 
                        DrawText3D(v.x, v.y, v.z + 0.5, '~g~G~s~ - Portakal Ayrıl')
                    if IsControlJustReleased(0, 47) then
                    cik()
                    end
                    end
                  
                    if distance < markerSize.x then
                        isInMarker, currentZone = true, k
                    end
                end
                Citizen.Wait(sleep)
            end
        end
        end)

        Citizen.CreateThread(function()
            while true do
                local sleep = 7
                 local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(ped), false, nil, true
        
                for k,v in pairs(araccikar) do
                    local distance = #(playerCoords - v)
        
                    if distance < 1 then
                        letSleep = false
                        sleep = 2
                        if portakaldami == false then 
                        else 
                         DrawText3D(v.x, v.y, v.z + 0.5, '~g~G~s~ - Araç Çıkar')
                        if IsControlJustReleased(0, 47) then
                            aracikrds()
                        end
                        end
                      
                        if distance < markerSize.x then
                            isInMarker, currentZone = true, k
                        end
                    end
                    Citizen.Wait(sleep)
                end
            end
            end)

            Citizen.CreateThread(function()
                while true do
                    local sleep = 7
                     local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(ped), false, nil, true
            
                    for k,v in pairs(aracsil) do
                        local distance = #(playerCoords - v)
            
                        if distance < 3.0 then
                            letSleep = false
                            sleep = 2
                            if portakaldami == false then 
                            else 
                             DrawText3D(v.x, v.y, v.z + 0.5, '~g~E~s~ - Aracı Sil')
                            if IsControlJustReleased(0, 38) then
                                aracparaver()
                            end
                            end
                          
                            if distance < markerSize.x then
                                isInMarker, currentZone = true, k
                            end
                        end
                        Citizen.Wait(sleep)
                    end
                end
                end)

                Citizen.CreateThread(function()
                    while true do
                        local sleep = 7
                         local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(ped), false, nil, true
                
                        for k,v in pairs(satis) do
                            local distance = #(playerCoords - v)
                
                            if distance < 3.0 then
                                letSleep = false
                                sleep = 2
                                if portakaldami == false then 
                                else 
                                 DrawText3D(v.x, v.y, v.z + 0.5, '~g~E~s~ - Portakal Satıs 1KG = 5 Portakal = 1000$')
                                if IsControlJustReleased(0, 38) then
                                    TriggerServerEvent("kibra-meslekportakal:satis")
                                end
                                end
                              
                                if distance < markerSize.x then
                                    isInMarker, currentZone = true, k
                                end
                            end
                            Citizen.Wait(sleep)
                        end
                    end
                    end)

                

RegisterNetEvent('kibra-meslekportakal:aracVer')
AddEventHandler('kibra-meslekportakal:aracVer', function ()
    if vehicle == nil then
        local modelHash = GetHashKey("Rebel")
        RequestModel("rebel")
        local isLoaded = HasModelLoaded("rebel")
        while isLoaded == false do
            Citizen.Wait(1000)
        end
        vehicle = CreateVehicle("rebel", aracyer, 145.50, 1, 0)
        exports['swt_notifications']:Success("Portakal Mesleği","Aracınız oluşturuldu","top",2000,true)
    else
        exports['swt_notifications']:Negative("Portakal Mesleği","Zaten aracınız var","top",2000,true)
    end
end)
       RegisterCommand("gir", function()
            portakaldami = true
        end)

        function aracikrds()
            if vehicle == nil then
                TriggerServerEvent('kibra-meslekportakal:aracalo')
            else
                exports['swt_notifications']:Negative("Portakal Mesleği","Zaten aracınız var","top",2000,true)
            end
        end




        
        function gir() portakaldami = true exports['swt_notifications']:Success("Portakal Mesleği","Portakalcılığa başladınız","top",2000,true)  end
        function cik() portakaldami = false exports['swt_notifications']:Negative("Portakal Mesleği","Portakalcılıktan ayrıldınız","top",2000,true) end


        function aracparaver()
            if vehicle ~= nil then
                    DeleteEntity(vehicle)
                    DeleteVehicle(vehicle)
                    ESX.Game.DeleteVehicle(vehicle)
                    vehicle = nil
                    exports['swt_notifications']:Success("Portakal Mesleği","Aracınız silindi","top",2000,true)
                    TriggerServerEvent('kibra-meslekportakal:verPara')
                else
                    exports['swt_notifications']:Info("Portakal Mesleği","Binip Tekrar Deneyin","top",2000,true)
                end
            
        end

    function kibraPrtklTopla()
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 10000,
            label = "Portakal Topluyorsun",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                anim = "high_center_up",
            },
        }, function(status)
            if not status then
            end
            TriggerServerEvent("kibra-meslekportakal:Topla")
        end)
    end

    

   -- Toplama
    Citizen.CreateThread(function()
          local blip = AddBlipForCoord(blips)
          SetBlipSprite(blip, 478)
          SetBlipDisplay(blip, 4)
          SetBlipScale(blip, 0.6)
          SetBlipColour(blip, 47)
          SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString('Portakal Toplama')
          EndTextCommandSetBlipName(blip)
        
    end)


    -- Başlangıç

    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(baslangicblip)
        SetBlipSprite(blip, 478)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 47)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Portakal Mesleği')
        EndTextCommandSetBlipName(blip)
      
  end)

    -- Satış
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(satisblip)
        SetBlipSprite(blip, 478)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 47)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Portakal Satış')
        EndTextCommandSetBlipName(blip)
      
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

    