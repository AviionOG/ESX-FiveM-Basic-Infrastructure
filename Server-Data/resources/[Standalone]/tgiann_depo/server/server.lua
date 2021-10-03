local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('tgiann:depo:server:readSQL', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local data = exports.ghmattimysql:executeSync('SELECT * FROM depolar')
    local user = ESX.GetPlayerFromId(src)
    cb(data)
end)

RegisterServerEvent('tgiann:depo:server:sat')
AddEventHandler('tgiann:depo:server:sat', function(data)
    local identifier = GetPlayerIdentifiers(source)[1]
    if identifier ~= nil then
        exports.ghmattimysql:executeSync('DELETE FROM depolar WHERE identifier = @identifier',
        { ['@identifier'] = identifier }
        )
    end
end)

ESX.RegisterServerCallback('tgiann:depo:writesql', function(source, cb, data)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    if(xPlayer.getMoney() >= 5000) then
        print(json.encode(data))
        local identifier = GetPlayerIdentifiers(source)[1]
        local num = math.random(9) .. math.random(9) .. math.random(9) .. math.random(9)
        exports.ghmattimysql:executeSync('INSERT INTO depolar (ad, sifre, num, identifier) VALUES (@ad, @sifre, @num, @identifier)',
        {
          ['@ad']       = data.ad,
          ['@sifre']    = data.sifre,
          ['@num']      = num,
          ['@identifier']   = identifier
        },
        function( result )
          cb(true)
        end)
        xPlayer.removeMoney(5000) -- para silme
        TriggerEvent('tgianndepo:log:basarili')
    else
        TriggerClientEvent('just_stash:client:paramyok', source)
        TriggerEvent('tgianndepo:log:basarisiz')
    end
end)