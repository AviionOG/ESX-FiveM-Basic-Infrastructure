ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local WeaponAmmo = {}

ESX.RegisterServerCallback("weapons:server:GetConfig", function(source, cb)
    cb(Config.WeaponRepairPoints)
end)

--RegisterServerEvent("weapons:server:LoadWeaponAmmo")
 --AddEventHandler('weapons:server:LoadWeaponAmmo', function()
	--local src = source
   -- local Player = ESX.GetPlayerFromId(src)
   --WeaponAmmo[Player.PlayerData.citizenid] = {}
   -- QBCore.Functions.ExecuteSql(false, "SELECT * FROM `playerammo` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
      -- if result[1] ~= nil then
           -- local ammo = json.decode(result[1].ammo)
           -- if ammo ~= nil then
               --for ammotype, amount in pairs(ammo) do 
               --   WeaponAmmo[Player.PlayerData.citizenid][ammotype] = amount
             --   end
           -- end
       -- end
 	--end)
--end)

RegisterServerEvent("weapons:server:AddWeaponAmmo")
AddEventHandler('weapons:server:AddWeaponAmmo', function(CurrentWeaponData, amount)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local amount = tonumber(amount)

    if CurrentWeaponData ~= nil then
        if Player.inventory[CurrentWeaponData.slot] ~= nil then
            if Player.inventory[CurrentWeaponData.slot].info == nil then
                Player.inventory[CurrentWeaponData.slot].info.ammo = amount
            end
        end
        Player.SetInventory(Player.inventory)
    end
end)

RegisterServerEvent("weapons:server:UpdateWeaponAmmo")
AddEventHandler('weapons:server:UpdateWeaponAmmo', function(CurrentWeaponData, amount)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local amount = tonumber(amount)
    if CurrentWeaponData ~= nil then
        if Player ~= nil then
            if Player.inventory[CurrentWeaponData.slot] ~= nil then
                Player.inventory[CurrentWeaponData.slot].info.ammo = amount
            end
            Player.SetInventory(Player.inventory)
        end
    end
end)

ESX.RegisterServerCallback("weapon:server:GetWeaponAmmo", function(source, cb, WeaponData)
    local Player = ESX.GetPlayerFromId(source)
    local retval = 0
    if WeaponData ~= nil then
        if Player ~= nil then
            local ItemData = Player.GetItemBySlot(WeaponData.slot)
            if ItemData ~= nil then
                retval = ItemData.info.ammo ~= nil and ItemData.info.ammo or 0
            end
        end
    end
    cb(retval)
end)

RegisterServerEvent("removefalanfilan")
AddEventHandler('removefalanfilan', function(itemName, amount)
	local src = source
    local Player = ESX.GetPlayerFromId(src)
    Player.removeInventoryItem(itemName, amount)
    TriggerClientEvent('inventory:client:ItemBox',src,ESX.GetItems()[itemName],'remove',amount)
end)

ESX.RegisterUsableItem("pistol_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_PISTOL", 12, item)
end)

ESX.RegisterUsableItem("rifle_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_RIFLE", 20, item)
end)

ESX.RegisterUsableItem("smg_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_SMG", 20, item)
end)

ESX.RegisterUsableItem("shotgun_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_SHOTGUN", 10, item)
end)

ESX.RegisterUsableItem("mg_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_MG", 30, item)
end)
ESX.RegisterUsableItem("sniper_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_SNIPER", 7, item)
end)

function IsWeaponBlocked(WeaponName)
    local retval = false
    for _, name in pairs(Config.DurabilityBlockedWeapons) do
        if name == WeaponName then
            retval = true
            break
        end 
    end
    return retval
end

-- RegisterServerEvent('weapons:server:UpdateWeaponQuality')
-- AddEventHandler('weapons:server:UpdateWeaponQuality', function(data)
--     local src = source
--     local Player = ESX.GetPlayerFromId(src)
--     local WeaponData = QBCore.Shared.Weapons[GetHashKey(data.name)]
--     local WeaponSlot = Player.inventory[data.slot]
--     local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    
--     if not IsWeaponBlocked(WeaponData.name) then
--         if WeaponSlot.info.quality ~= nil then
--             if WeaponSlot.info.quality - DecreaseAmount > 0 then
--                 WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
--             else
--                 WeaponSlot.info.quality = 0
--                 TriggerClientEvent('inventory:client:UseWeapon', src, data)
--                 TriggerClientEvent('QBCore:Notify', src, "Jouw wapen is gebroken, je moet dit wapen repareren voordat je hem weer kunt gebruiken.", "error")
--             end
--         else
--             WeaponSlot.info.quality = 100
--             if WeaponSlot.info.quality - DecreaseAmount > 0 then
--                 WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
--             else
--                 WeaponSlot.info.quality = 0
--                 TriggerClientEvent('inventory:client:UseWeapon', src, data)
--                 TriggerClientEvent('QBCore:Notify', src, "Jouw wapen is gebroken, je moet dit wapen repareren voordat je hem weer kunt gebruiken.", "error")
--             end
--         end
--         Player.Functions.SetInventory(Player.inventory)
--     end
-- end)

RegisterServerEvent('weapons:server:UpdateWeaponQuality')
AddEventHandler('weapons:server:UpdateWeaponQuality', function(data, RepeatAmount)
    if data ~= nil then
    local Player = ESX.GetPlayerFromId(source)
    local WeaponData = Config.Weapons[GetHashKey(data.name)]
    local WeaponSlot = Player.inventory[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    if WeaponSlot ~= nil then
        if not IsWeaponBlocked(WeaponData.name) then
            if WeaponSlot.info.quality ~= nil then
                for i = 1, RepeatAmount, 1 do
                    if WeaponSlot.info ~= nil then
                        if WeaponSlot.info.quality - DecreaseAmount > 0 then
                            WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount

                        else
                            WeaponSlot.info.quality = 0
                            TriggerClientEvent('inventory:client:UseWeapon', source, data)
                            TriggerClientEvent('Kibra:Notify', source, 'Başarısız', 'Silahınız Kırılmış!', 3000, 'error')
                            break
                        end
                    end
                end
            else
                WeaponSlot.info.quality = 100
                for i = 1, RepeatAmount, 1 do
                    if WeaponSlot.info.quality - DecreaseAmount > 0 then
                        WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount

                    else
                        WeaponSlot.info.quality = 0
                        TriggerClientEvent('inventory:client:UseWeapon', source, data)
                        TriggerClientEvent('Kibra:Notify', source, 'Başarısız', 'Silahınız Kırılmış!', 3000, 'error')
                        break
                    end
                end
            end
        end

    end
    Player.SetInventory(Player.inventory)
end

end)

-- RegisterCommand("repairweapon",function(source, args)
--     TriggerClientEvent('weapons:client:SetWeaponQuality', source, tonumber(args[1]))
-- end)

RegisterServerEvent("weapons:server:SetWeaponQuality")
AddEventHandler("weapons:server:SetWeaponQuality", function(data, hp)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local WeaponData = ESX.GetWeaponList[GetHashKey(data.name)]
    local WeaponSlot = Player.inventory[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    WeaponSlot.info.quality = hp
    Player.SetInventory(Player.inventory)
end)

ESX.RegisterServerCallback("weapons:server:RepairWeapon", function(source, cb, RepairPoint, data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local minute = 1
    local Timeout = 1 --math.random(5 * minute, 10 * minute)
    local WeaponData = Config.Weapons[GetHashKey(data.name)]
    local WeaponClass = (SplitStr(WeaponData.ammotype, "_")[2]):lower()
    if Player.inventory[data.slot] ~= nil then
        if Player.inventory[data.slot].info.quality ~= nil then
            if Player.inventory[data.slot].info.quality ~= 100 then
                if Player.getMoney() >= Config.WeaponRepairCotsts[WeaponClass] then
                    Player.removeMoney(Config.WeaponRepairCotsts[WeaponClass])
                    Config.WeaponRepairPoints[RepairPoint].IsRepairing = true
                    Config.WeaponRepairPoints[RepairPoint].RepairingData = {
                        identifier = Player.identifier,
                        WeaponData = Player.inventory[data.slot],
                        Ready = false,
                    }
                    Player.removeInventoryItem(data.name, 1, data.slot)
                   -- TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.name], "remove")
                    TriggerClientEvent("inventory:client:CheckWeapon", src, data.name)
                    TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)

                    SetTimeout(15000, function()
                        Config.WeaponRepairPoints[RepairPoint].IsRepairing = false
                        Config.WeaponRepairPoints[RepairPoint].RepairingData.Ready = true
                        TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)
                        TriggerClientEvent('Kibra:Notify', src, 'Başarılı', 'Silahınız tamir edildi!', 3000, 'success')
                        SetTimeout(15000, function()
                            if Config.WeaponRepairPoints[RepairPoint].RepairingData.Ready then
                                Config.WeaponRepairPoints[RepairPoint].IsRepairing = false
                                Config.WeaponRepairPoints[RepairPoint].RepairingData = {}
                                TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)
                            end
                       end)
                    end)
                    TriggerClientEvent('Kibra:Notify', src, 'Başarılı', 'Silahınız tamir ediliyor!', 3000, 'success')
                    cb(true)
                else
                    cb(false)
                end
            else
                TriggerClientEvent('Kibra:Notify', src, 'Sorun Yok!', 'Silahınız hasarlı değil!', 3000, 'info')

                cb(false)
            end
        else
            TriggerClientEvent('Kibra:Notify', src, 'Sorun Yok!', 'Silahınız hasarlı değil!', 3000, 'info')
            cb(false)
        end
    else
        TriggerClientEvent('Kibra:Notify', src, 'Elinde Yok!', 'Elinde Silah Yok', 3000, 'error')
        TriggerClientEvent('weapons:client:SetCurrentWeapon', src, {}, false)
        cb(false)
    end
end)

RegisterServerEvent("weapons:server:TakeBackWeapon")
AddEventHandler("weapons:server:TakeBackWeapon", function(k, data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local itemdata = Config.WeaponRepairPoints[k].RepairingData.WeaponData

    itemdata.info.quality = 100
    Player.addInventoryItem(itemdata.name, 1, false, itemdata.info)
   -- TriggerClientEvent('inventory:client:ItemBox', src, 'weapon_appistol', "add")
    Config.WeaponRepairPoints[k].IsRepairing = false
    Config.WeaponRepairPoints[k].RepairingData = {}
    TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[k], k)
end)

ESX.RegisterUsableItem("pistol_suppressor", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

ESX.RegisterUsableItem("pistol_extended", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extended")
end)

ESX.RegisterUsableItem("smg_suppressor", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

ESX.RegisterUsableItem("rifle_suppressor", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

ESX.RegisterUsableItem("pistol_extendedclip", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

ESX.RegisterUsableItem("smg_extendedclip", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

ESX.RegisterUsableItem("smg_flashlight", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "flashlight")
end)

ESX.RegisterUsableItem("pistol_flashlight", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "flashlight")
end)

ESX.RegisterUsableItem("rifle_flashlight", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "flashlight")
end)

ESX.RegisterUsableItem("pistol_scope", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "scope")
end)

ESX.RegisterUsableItem("rifle_scope", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "scope")
end)

ESX.RegisterUsableItem("smg_scope", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "scope")
end)


ESX.RegisterUsableItem("rifle_extendedclip", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

ESX.RegisterUsableItem("rifle_drummag", function(source, item)
    local Player = ESX.GetPlayerFromId(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "drummag")
end)

function HasAttachment(component, attachments)
    local retval = false
    local key = nil
    for k, v in pairs(attachments) do
        if v.component == component then
            key = k
            retval = true
        end
    end
    return retval, key
end

function GetAttachmentItem(weapon, component)
    local retval = nil
    for k, v in pairs(Config.WeaponAttachments[weapon]) do
        if v.component == component then
            retval = v.item
        end
    end
    return retval
end

RegisterServerEvent("weapons:server:EquipAttachment")
AddEventHandler("weapons:server:EquipAttachment", function(ItemData, CurrentWeaponData, AttachmentData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local Inventory = Player.inventory
    local GiveBackItem = nil
    if Inventory[CurrentWeaponData.slot] ~= nil then
        if Inventory[CurrentWeaponData.slot].info.attachments ~= nil and next(Inventory[CurrentWeaponData.slot].info.attachments) ~= nil then
            local HasAttach, key = HasAttachment(AttachmentData.component, Inventory[CurrentWeaponData.slot].info.attachments)
            if not HasAttach then
                if CurrentWeaponData.name == "weapon_compactrifle" then
                    local component = "COMPONENT_COMPACTRIFLE_CLIP_03"
                    if AttachmentData.component == "COMPONENT_COMPACTRIFLE_CLIP_03" then
                        component = "COMPONENT_COMPACTRIFLE_CLIP_02"
                    end
                    for k, v in pairs(Inventory[CurrentWeaponData.slot].info.attachments) do
                        if v.component == component then
                            local has, key = HasAttachment(component, Inventory[CurrentWeaponData.slot].info.attachments)
                            local item = GetAttachmentItem(CurrentWeaponData.name:upper(), component)
                            GiveBackItem = tostring(item):lower()
                            table.remove(Inventory[CurrentWeaponData.slot].info.attachments, key)
                            --TriggerClientEvent('inventory:client:ItemBox', src, ESX.Items[item], "add")
                        end
                    end
                end
                table.insert(Inventory[CurrentWeaponData.slot].info.attachments, {
                    component = AttachmentData.component,
                    label = AttachmentData.label,
                })
                TriggerClientEvent("addAttachment", src, AttachmentData.component)
                Player.SetInventory(Player.inventory)
                Player.removeInventoryItem(ItemData.name, 1)
                SetTimeout(1000, function()
                    TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "remove",1)
                end)
            else
                TriggerClientEvent('Kibra:Notify', src, 'Başarısız!', AttachmentData.label:lower().." zaten silahında takılı", 3000, 'info')
            end
        else
            Inventory[CurrentWeaponData.slot].info.attachments = {}
            table.insert(Inventory[CurrentWeaponData.slot].info.attachments, {
                component = AttachmentData.component,
                label = AttachmentData.label,
            })
            TriggerClientEvent("addAttachment", src, AttachmentData.component)
            Player.SetInventory(Player.inventory)
            Player.removeInventoryItem(ItemData.name, 1)
            SetTimeout(1000, function()
                TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "remove",1)
            end)
        end
    end

    if GiveBackItem ~= nil then
        Player.addInventoryItem(GiveBackItem, 1, false)
        GiveBackItem = nil
    end
end)

ESX.RegisterServerCallback('weapons:server:RemoveAttachment', function(source, cb, AttachmentData, ItemData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local Inventory = Player.inventory
    local AttachmentComponent = Config.WeaponAttachments[ItemData.name:upper()][AttachmentData.attachment]

    if Inventory[ItemData.slot] ~= nil then
        if Inventory[ItemData.slot].info.attachments ~= nil and next(Inventory[ItemData.slot].info.attachments) ~= nil then
            local HasAttach, key = HasAttachment(AttachmentComponent.component, Inventory[ItemData.slot].info.attachments)
            if HasAttach then
                table.remove(Inventory[ItemData.slot].info.attachments, key)
                Player.SetInventory(Player.inventory)
                Player.addInventoryItem(AttachmentComponent.item, 1)
                TriggerClientEvent('Kibra:Notify', src, 'Başarısız!', AttachmentComponent.label.." parcasini sildin!", 3000, 'info')
                cb(Inventory[ItemData.slot].info.attachments)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
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




