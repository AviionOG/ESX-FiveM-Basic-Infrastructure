ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local aracfiyat = 500
local webhook = "https://discord.com/api/webhooks/857718659233480724/5DZ5fsTYQ6KfyMJ3ngxBkDHHb2w0IKEzsPDG_-HR6ocDiQvL4v4MNm6BQNvehCz495N2"
RegisterServerEvent("kibra-meslekportakal:Topla")
AddEventHandler("kibra-meslekportakal:Topla", function()
local x = ESX.GetPlayerFromId(source)
x.addInventoryItem('portakal', 1)
TriggerClientEvent("swt_notifications:Success",source,"Portakal Toplama","1 Tane Portakal topladınız!","top",2000,true)

end)

RegisterServerEvent('kibra-meslekportakal:aracalo')
AddEventHandler('kibra-meslekportakal:aracalo', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if aracfiyat < xPlayer.getMoney() then
		xPlayer.removeMoney(aracfiyat)  
        xPlayer.addInventoryItem("vehiclekey", 1, false, info) 
		TriggerClientEvent('kibra-meslekportakal:aracVer', src)
	else
        TriggerClientEvent("swt_notifications:Negative",src,"Portakal İşleme","Paranız yok","top",2000,true)
	end
end)


RegisterServerEvent('kibra-meslekportakal:verPara')
AddEventHandler('kibra-meslekportakal:verPara', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addMoney(aracfiyat)
end)


RegisterServerEvent("kibra-meslekportakal:satis")
AddEventHandler("kibra-meslekportakal:satis", function()
	local src = source
	local x = ESX.GetPlayerFromId(source)
	local isim1 = exports.ghmattimysql:executeSync("SELECT * FROM users WHERE identifier = @identifier", { ['@identifier'] = x.identifier })
     local ad_soyad = isim1[1].firstname.." "..isim1[1].lastname
if x.getQuantity('portakal') >= 5 then 
	x.removeInventoryItem('portakal', 5)
	x.addMoney(5000)
    TriggerClientEvent('Kibra:Notify', src, 'Portakal Satış', 'Portakal Satış Yaparak 5000$ kazandınız!', 3000,'success')
	dclog(xPlayer, '**'..ad_soyad..' 1KG = 5 Portakal  satışı yaparak 5000$ kazandı**' )

else 
    TriggerClientEvent('Kibra:Notify', src, 'Portakal Satış', 'Yeterli Portakalınız Yok!', 3000,'error')
end
end)

function dclog(xPlayer, text)
	local xPlayer = ESX.GetPlayerFromId(source)
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = "Kibra-V2 Portakal Mesleği",
        ["avatar_url"] = "https://cdn.discordapp.com/attachments/856192457091448872/856192840421867570/62299912.png",
        ["embeds"] = {{
            ["author"] = {
                ["name"] = "Kibra-V2 Portakal SATIŞ"
            },
            ["color"] = 1942002,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&'] = '&amp;',
        ['<'] = '&lt;',
        ['>'] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
    :gsub('[&<>\n]', replacements)
    :gsub(' +', function(s)
        return ' '..('&nbsp;'):rep(#s-1)
    end)
end