-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function setSettings(player, profile)
end
local function setProfileData(player, profile)
	if profile == nil then
		return nil
	end
	-- leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	local Cash = leaderstats:FindFirstChild("Cash")
	Cash.Value = profile.Data.cash
	-- inventory ui
	local _exp = profile.Data.inventory
	-- ▼ ReadonlyMap.forEach ▼
	local _callback = function(item, key)
		item.equipped = false
		Network.GiveItemEvent:Fire(player, item)
	end
	for _k, _v in _exp do
		_callback(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
end
local function createSetup(player)
	-- leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	local Cash = Instance.new("NumberValue")
	Cash.Name = "Cash"
	Cash.Value = 0
	leaderstats.Parent = player
	Cash.Parent = leaderstats
end
local function setDataDEBUG(player)
	-- add item
	local weapon = {
		name = "FireStaff",
		itemType = "Weapon",
		equipped = false,
	}
	local armore = {
		name = "FireStaff",
		itemType = "Armore",
		armoreType = "Hat",
		equipped = false,
	}
	Network.GiveItemEvent:Fire(player, weapon)
	Network.GiveItemEvent:Fire(player, weapon)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
end
-- setup
local function loadData(player, profile)
	if profile == nil then
		return nil
	end
	createSetup(player)
	setProfileData(player, profile)
	setSettings(player, profile)
	setDataDEBUG(player)
end
return {
	loadData = loadData,
}
