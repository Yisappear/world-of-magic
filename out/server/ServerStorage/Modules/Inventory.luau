-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
-- private functions
local function onEquip(player, data)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	local _inventory = profile.Data.inventory
	local _uuid = data.uuid
	local itemInInventory = _inventory[_uuid]
	if itemInInventory == nil then
		return nil
	end
	local function giveWeapon()
		if itemInInventory == nil then
			return nil
		end
		Network.WeaponEquipEvent:FireClient(player)
		Network.EquipItemEvent:FireClient(player, data)
		Network.DelItemEvent:FireClient(player, data)
		player:SetAttribute(GameConfig.WEAPON_ATTRIBUTE, itemInInventory.name)
	end
	local function giveArmore()
		Network.EquipItemEvent:FireClient(player, data)
		Network.DelItemEvent:FireClient(player, data)
	end
	local countEquippedItems = {}
	local _exp = profile.Data.inventory
	-- ▼ ReadonlyMap.forEach ▼
	local _callback = function(item, key)
		if item.equipped == true then
			local _item = item
			table.insert(countEquippedItems, _item)
			if item.itemType == "Weapon" then
				giveWeapon()
			end
			if item.itemType == "Armore" then
				giveArmore()
			end
		end
	end
	for _k, _v in _exp do
		_callback(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
	if (#countEquippedItems - 1) == 4 then
		return nil
	end
	local hasWeapon = false
	local hasArmore = false
	for _, item in countEquippedItems do
		if item.itemType == "Weapon" then
			hasWeapon = true
		end
		if item.itemType == "Armore" then
			if item.armoreType == itemInInventory.armoreType then
				hasArmore = true
			end
		end
	end
	if hasArmore == false and hasWeapon == false then
		itemInInventory.equipped = true
		if itemInInventory.itemType == "Armore" then
			giveArmore()
		end
		if itemInInventory.itemType == "Weapon" then
			giveWeapon()
		end
	end
end
local function onUnequip(player, data)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	local _inventory = profile.Data.inventory
	local _uuid = data.uuid
	local itemInInventory = _inventory[_uuid]
	if itemInInventory == nil then
		return nil
	end
	itemInInventory.equipped = false
	-- remotes
	player:SetAttribute(GameConfig.WEAPON_ATTRIBUTE, "")
	Network.UnequipItemEvent:FireClient(player, data)
	Network.NewItemEvent:FireClient(player, data)
	if itemInInventory.itemType == "Weapon" then
		Network.WeaponUnequipEvent:FireClient(player)
	end
	-- notification
end
local function onSell(player, data)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	local _inventory = profile.Data.inventory
	local _uuid = data.uuid
	local itemInInventory = _inventory[_uuid]
	if itemInInventory == nil then
		return nil
	end
	if itemInInventory.equipped == true then
		itemInInventory.equipped = false
		local _inventory_1 = profile.Data.inventory
		local _uuid_1 = data.uuid
		_inventory_1[_uuid_1] = nil
		Network.UnequipItemEvent:FireClient(player, data)
		return nil
	end
	itemInInventory.equipped = false
	local _inventory_1 = profile.Data.inventory
	local _uuid_1 = data.uuid
	_inventory_1[_uuid_1] = nil
	-- remotes
	Network.DelItemEvent:FireClient(player, data)
	-- notification
	-- reward
end
local function addItem(player, data)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	if data == nil then
		return nil
	end
	-- inventory max slots
	-- ▼ ReadonlyMap.size ▼
	local _size = 0
	for _ in profile.Data.inventory do
		_size += 1
	end
	-- ▲ ReadonlyMap.size ▲
	local itemCount = _size
	local maxCount = profile.Data.max_items
	if itemCount >= maxCount then
		return nil
	end
	-- create item
	local uuid = HttpService:GenerateGUID(false)
	if data.itemType == "Armore" then
		local _inventory = profile.Data.inventory
		local _arg1 = {
			name = data.name,
			itemType = data.itemType,
			armoreType = data.armoreType,
			equipped = data.equipped,
		}
		_inventory[uuid] = _arg1
	end
	if data.itemType == "Weapon" then
		local _inventory = profile.Data.inventory
		local _arg1 = {
			name = data.name,
			itemType = data.itemType,
			equipped = data.equipped,
		}
		_inventory[uuid] = _arg1
	end
	local sendData = {
		uuid = uuid,
		name = data.name,
		itemType = data.itemType,
	}
	-- remotes
	Network.NewItemEvent:FireClient(player, sendData)
	-- notification
end
local function loadInventory(player)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	local _exp = profile.Data.inventory
	-- ▼ ReadonlyMap.forEach ▼
	local _callback = function(item, key)
		local sendData = {
			uuid = key,
			name = item.name,
			itemType = item.itemType,
		}
		Network.NewItemEvent:FireClient(player, sendData)
		if item.equipped == true then
			onEquip(player, sendData)
		end
		task.wait(.1)
	end
	for _k, _v in _exp do
		_callback(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
end
local function isEquipped(player, uuid)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return false
	end
	local _inventory = profile.Data.inventory
	local _uuid = uuid
	local itemInInventory = _inventory[_uuid]
	if itemInInventory == nil then
		return false
	end
	return itemInInventory.equipped
end
-- setup
-- remote event
Network.EquipItemEvent.OnServerEvent:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	onEquip(player, data)
end)
Network.UnequipItemEvent.OnServerEvent:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	onUnequip(player, data)
end)
Network.DelItemEvent.OnServerEvent:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	onSell(player, data)
end)
-- remote function
Network.IsEquipped.OnServerInvoke = function(player, args)
	if args == nil then
		return nil
	end
	local uuid = args
	return isEquipped(player, uuid)
end
-- bindable event
Network.GiveItemToPlayerEvent.Event:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	addItem(player, data)
end)
Network.LoadInventoryEvent.Event:Connect(function(player, args)
	loadInventory(player)
end)
return nil
