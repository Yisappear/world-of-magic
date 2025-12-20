-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
-- private functions
local function renderArmore(player)
end
local function onUnequip(player)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("rejoin please, you're profile dont loaded")
		return nil
	end
	local armoreInventory = profile.Data.inventory
	player:SetAttribute(GameConfig.ARMORE_ATTRIBUTE, 0)
end
local function onEquip(player)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("rejoin please, you're profile dont loaded")
		return nil
	end
	local equipped
	local armoreInventory = profile.Data.inventory
	-- render armore on character
end
Network.EquipArmoreEvent.OnServerEvent:Connect(function() end)
return nil
