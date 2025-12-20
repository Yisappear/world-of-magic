-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
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
	local hasItemEquipped = false
	local allEquippedItems = {}
	local _exp = profile.Data.inventory
	-- ▼ ReadonlyMap.forEach ▼
	local _callback = function(item, key)
		if item.equipped == true then
			local _key = key
			local _item = item
			allEquippedItems[_key] = _item
			if item.itemType == itemInInventory.itemType then
				if item.itemType == "Armore" then
					if item.armoreType == itemInInventory.armoreType then
						return nil
					end
				end
				-- hasItemEquipped = true PROBLEM HERE if weapon -> problom
			end
		end
	end
	for _k, _v in _exp do
		_callback(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
	if hasItemEquipped then
		return nil
	end
	itemInInventory.equipped = true
	-- remotes
	Network.EquipItemEvent:FireClient(player, data)
	Network.DelItemEvent:FireClient(player, data)
	-- notification
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
	Network.UnequipItemEvent:FireClient(player, data)
	Network.AddItemEvent:FireClient(player, data)
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
		onUnequip(player, data)
		local _inventory_1 = profile.Data.inventory
		local _uuid_1 = data.uuid
		_inventory_1[_uuid_1] = nil
		Network.UnequipItemEvent:FireClient(player, data)
		return nil
	end
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
	local uuid = HttpService:GenerateGUID(false)
	local _inventory = profile.Data.inventory
	local _arg1 = {
		name = data.name,
		itemType = data.itemType,
		equipped = false,
	}
	_inventory[uuid] = _arg1
	if data.itemType == "Armore" then
		local _inventory_1 = profile.Data.inventory
		local _arg1_1 = {
			name = data.name,
			itemType = data.itemType,
			armoreType = data.armoreType,
			equipped = false,
		}
		_inventory_1[uuid] = _arg1_1
	end
	local sendData = {
		uuid = uuid,
		name = data.name,
		itemType = data.itemType,
	}
	-- remotes
	Network.AddItemEvent:FireClient(player, sendData)
	-- notification
	-- add ui
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
Network.GiveItemEvent.Event:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	addItem(player, data)
end)
Network.DelItemEvent.OnServerEvent:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local data = args
	onSell(player, data)
end)
Network.IsEquipped.OnServerInvoke = function(player, args)
	if args == nil then
		return nil
	end
	local uuid = args
	return isEquipped(player, uuid)
end
return {
	addItem = addItem,
}
