-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local _PlayerData = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "PlayerData")
local getNewProfile = _PlayerData.getNewProfile
local removeProfile = _PlayerData.removeProfile
local createLeaderstatsForPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").createLeaderstatsForPlayer
-- types
-- module logic
local players = {}
-- private functions
local function newPlayer(player)
	local data = getNewProfile(player)
	if data == nil then
		player:Kick("Profile error, please rejoin.")
		return nil
	end
	createLeaderstatsForPlayer(player)
	local _arg0 = {
		player = player,
		data = data,
	}
	table.insert(players, _arg0)
end
local function removePlayer(player)
	removeProfile(player)
	-- ▼ ReadonlyArray.findIndex ▼
	local _callback = function(v)
		return v.player == player
	end
	local _result = -1
	for _i, _v in players do
		if _callback(_v, _i - 1, players) == true then
			_result = _i - 1
			break
		end
	end
	-- ▲ ReadonlyArray.findIndex ▲
	local idx = _result
	table.remove(players, idx + 1)
end
-- export
local function getPlayerStruct(player)
	for _, i in players do
		if i.player == player then
			return i
		end
	end
	player:Kick("PlayerStruct don't exist.")
	return nil
end
-- setup
Players.PlayerAdded:Connect(newPlayer)
Players.PlayerRemoving:Connect(removePlayer)
return {
	getPlayerStruct = getPlayerStruct,
}
