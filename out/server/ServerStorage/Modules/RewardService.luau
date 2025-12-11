-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local rewardConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "RewardConfig").default
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local setLeaderstatValues = TS.import(script, game:GetService("ServerStorage"), "Modules", "Notification").setLeaderstatValues
local function onKillReward(player)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick(`Profile session end - Please rejoin`)
		return nil
	end
	local reward = rewardConfig.killReward
	local newCashValue = profile.Data.Cash + reward.cash
	profile.Data.Cash = newCashValue
	setLeaderstatValues(player)
end
return {
	onKillReward = onKillReward,
}
