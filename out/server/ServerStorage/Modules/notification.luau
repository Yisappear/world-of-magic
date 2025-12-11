-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local function setLeaderstatValues(player)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick(`Profile session end - Please rejoin`)
		return nil
	end
	local leaderstats = player:FindFirstChild("leaderstats")
	local cash = leaderstats:FindFirstChild("Cash")
	-- new data
	local newCashValue = profile.Data.Cash
	-- setup
	cash.Value = newCashValue
end
local inventoryNotification = {}
return {
	setLeaderstatValues = setLeaderstatValues,
	inventoryNotification = inventoryNotification,
}
