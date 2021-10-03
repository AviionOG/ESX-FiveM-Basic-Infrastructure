ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local src = source
    local rows    

    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]

    local result = exports.ghmattimysql:executeSync("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })

    local firstname = result[1].firstname 

    local resultVehicles = exports.ghmattimysql:executeSync('SELECT * FROM vehicles')

    TriggerClientEvent('vehicleshop.receiveInfo', src, xPlayer.getAccount('bank').money, firstname)    

    TriggerClientEvent("vehicleshop.vehiclesInfos", src , resultVehicles)

    TriggerClientEvent("vehicleshop.notify", src, 'error', _U('rotate_keys'))
end)



ESX.RegisterServerCallback('vehicleshop.isPlateTaken', function (source, cb, plate)
	exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    exports.ghmattimysql:execute('SELECT * FROM vehicles WHERE model = @model LIMIT 1', {
		['@model'] = veh
    }, function (result)
        if #result > 0 then
            local veiculo = result[1]
            local vehicleModel = veh
            local vehiclePrice = price
            local stockQtd = result[1].stock       
            if stockQtd > 0 then           
                if xPlayer.getAccount('bank').money >= tonumber(vehiclePrice) then
                    xPlayer.removeAccountMoney('bank', tonumber(vehiclePrice))
                    stockQtd = stockQtd - 1	                    
                    local vehiclePropsjson = json.encode(vehicleProps)
                    
                    local stateVehicle = 0 

                    if Config.SpawnVehicle then
                        stateVehicle = 0
                    else
                        stateVehicle = 1
                    end
                    
                    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle, @state)',
                    {
                        ['@owner']   = xPlayer.identifier,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = vehiclePropsjson,
                        ['@state'] = stateVehicle,
                    },
                    
                    function (rowsChanged)                     
                        exports.ghmattimysql:execute('UPDATE vehicles SET stock = @stock WHERE model = @model',
                        {
                            ['@stock'] = stockQtd,
                            ['@model'] = vehicleModel
                        })
                        info = {
                            model = vehicleModel,
                            plaka = vehicleProps.plate
                        }
                        xPlayer.addInventoryItem("carkey", 1, false, info)
                        TriggerClientEvent("vehicleshop.sussessbuy", source, name, vehicleProps.plate, vehiclePrice)
                        TriggerClientEvent('vehicleshop.receiveInfo', source, xPlayer.getAccount('bank').money)    
                        TriggerClientEvent('vehicleshop.spawnVehicle', source, vehicleModel, vehicleProps.plate)                       
                    end)
                else
                    TriggerClientEvent("vehicleshop.notify", source, 'error', _U('enough_money'))
                end
            else
                TriggerClientEvent("vehicleshop.notify", source, 'error', _U('we_dont_vehicle'))
            end  
        end
	end)
end)