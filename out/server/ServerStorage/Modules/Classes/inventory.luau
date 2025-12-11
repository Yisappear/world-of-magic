-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
local Inventory
do
	Inventory = setmetatable({}, {
		__tostring = function()
			return "Inventory"
		end,
	})
	Inventory.__index = Inventory
	function Inventory.new(...)
		local self = setmetatable({}, Inventory)
		return self:constructor(...) or self
	end
	function Inventory:constructor(player)
	end
	function Inventory:onStart(player)
		-- networking | notification
	end
	function Inventory:createItem(player, weaponType)
		local profile = getProfile(player)
		if profile == nil then
			player:Kick(`Profile session end - Please rejoin`)
			return nil
		end
		local uuid = HttpService:GenerateGUID(false)
		local itemValue = {
			equipped = false,
			uuid = uuid,
		}
		profile.Data.inventory.weapons[uuid] = itemValue
		-- notification / or fire ( update UI in client )
	end
	function Inventory:deleteItem(player, uuid)
		local profile = getProfile(player)
		if profile == nil then
			player:Kick(`Profile session end - Please rejoin`)
			return nil
		end
		local _weapons = profile.Data.inventory.weapons
		local _uuid = uuid
		_weapons[_uuid] = nil
	end
	function Inventory:getEquippedItems(player)
		local profile = getProfile(player)
		if profile == nil then
			player:Kick(`Profile session end - Please rejoin`)
			return nil
		end
		local allItems = {}
		local inventory = profile.Data.inventory.weapons
		-- forEach + push / or forEach + props.equipped === true + push
		local equippedItems = {}
		-- for + push
		return equippedItems
	end
	function Inventory:equipItem(player, uuid)
		local profile = getProfile(player)
		if profile == nil then
			player:Kick(`Profile session end - Please rejoin`)
			return nil
		end
		local _weapons = profile.Data.inventory.weapons
		local _uuid = uuid
		local item = _weapons[_uuid]
		if item == nil then
			return nil
		end
		item.equipped = true
		-- notification, or fire remote update UI
		-- WARN! player could have only ONE weapon
	end
	function Inventory:unequipItem(player, uuid)
		local profile = getProfile(player)
		if profile == nil then
			player:Kick(`Profile session end - Please rejoin`)
			return nil
		end
		local _weapons = profile.Data.inventory.weapons
		local _uuid = uuid
		local item = _weapons[_uuid]
		if item == nil then
			return nil
		end
		item.equipped = false
		-- notification / or fire update UI in client
	end
end
return {
	Inventory = Inventory,
}
