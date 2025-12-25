-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local notifyKillReward = TS.import(script, game:GetService("ServerStorage"), "Modules", "Notification").notifyKillReward
local getProfile = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").default
local function rewardForKill(player, amount, enemyName)
	local profile = getProfile(player)
	if profile == nil then
		player:Kick("Profile don't loaded")
		return nil
	end
	local leaderstats = player:FindFirstChild("leaderstats")
	local _result = leaderstats
	if _result ~= nil then
		_result = _result:FindFirstChild("Cash")
	end
	local cash = _result
	local newValue = profile.Data.cash + amount
	profile.Data.cash = newValue
	cash.Value = profile.Data.cash
	notifyKillReward(player, amount, enemyName)
end
return {
	rewardForKill = rewardForKill,
}
