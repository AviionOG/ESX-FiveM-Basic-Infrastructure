ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kibra-madenv2:aracGonder')
AddEventHandler('kibra-madenv2:aracGonder', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if Config.AracFiyat < xPlayer.getMoney() then
		xPlayer.removeMoney(Config.AracFiyat)
		TriggerClientEvent('kibra-madenv2:aracVer', src)
	else
        TriggerClientEvent("swt_notifications:Negative",src,"Madencilik","Paranız yok","top",2000,true)
	end
end)


RegisterNetEvent('kibra-madenv2:kazmaKontrol1')
AddEventHandler('kibra-madenv2:kazmaKontrol1', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getQuantity('kazma') < 1 then
        TriggerClientEvent("swt_notifications:Negative",source,"Madencilik","Kazmanız yok","top",2000,true)
    else 
        TriggerClientEvent('kibra-madenv2:kzln', source) 
	end	
end)


RegisterServerEvent('kibra-madenv2:verPara')
AddEventHandler('kibra-madenv2:verPara', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addMoney(Config.AracFiyat)
end)

RegisterServerEvent("kibra-madenv2:topla")
AddEventHandler("kibra-madenv2:topla", function()
local src = source 
local xPlayer = ESX.GetPlayerFromId(src)
if xPlayer.getQuantity('kazma') >= 1 then 
xPlayer.addInventoryItem("tas", 1)
TriggerClientEvent("swt_notifications:Success",src,"Madencilik","1 Tane taş kazdınız","top",2000,true)
else 
	TriggerClientEvent("swt_notifications:Negative",src,"Madencilik","Kazmanız yok!","top",2000,true)
end
end)

RegisterServerEvent("kibra-madenv2:Isle")
AddEventHandler("kibra-madenv2:Isle", function()
local src = source 
local xPlayer = ESX.GetPlayerFromId(src)
if xPlayer.getQuantity('tas') >= Config.GerekenTas then 
xPlayer.removeInventoryItem('tas', Config.GerekenTas)
xPlayer.addInventoryItem('eritilmis', 1)
else 
    TriggerClientEvent("swt_notifications:Negative",src,"Madencilik","Taşınız yok ("..Config.GerekenTas..')',"top",2000,true)
end
end)

RegisterServerEvent("kibra-madenv2:Sat")
AddEventHandler("kibra-madenv2:Sat", function()
local src = source 
local xPlayer = ESX.GetPlayerFromId(src)
if xPlayer.getQuantity('eritilmis') >= Config.Satmakicingereken then 
    xPlayer.removeInventoryItem('eritilmis', Config.Satmakicingereken)
    xPlayer.addMoney(Config.KacPara)
    TriggerClientEvent("swt_notifications:Success",src,"Madencilik",Config.KacPara..'$ kazandınız!',"top",2000,true)

else 
    TriggerClientEvent("swt_notifications:Negative",src,"Madencilik","Eritilmiş Taşınız yok ("..Config.Satmakicingereken..')',"top",2000,true)

end
end)
