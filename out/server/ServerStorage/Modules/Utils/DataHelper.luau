-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function setSettings(player, profile)
end
local function setData(player, profile)
	if profile == nil then
		return nil
	end
	-- leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	local Cash = leaderstats:FindFirstChild("Cash")
	Cash.Value = profile.Data.cash
	-- inventory ui
	Network.LoadInventoryEvent:Fire(player)
end
local function create(player)
	-- leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	local Cash = Instance.new("NumberValue")
	Cash.Name = "Cash"
	Cash.Value = 0
	leaderstats.Parent = player
	Cash.Parent = leaderstats
end
local function DEBUG(player)
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
	Network.GiveItemToPlayerEvent:Fire(player, weapon)
	Network.GiveItemToPlayerEvent:Fire(player, weapon)
	Network.GiveItemToPlayerEvent:Fire(player, armore)
end
-- setup
local function loadData(player, profile)
	if profile == nil then
		return nil
	end
	create(player)
	setData(player, profile)
	setSettings(player, profile)
	DEBUG(player)
end
return {
	loadData = loadData,
}
