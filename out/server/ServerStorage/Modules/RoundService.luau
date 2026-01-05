-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
local playingPlayers = {}
-- private functions
local function newPlayer(player)
	local t = Workspace:GetServerTimeNow()
	local _arg0 = {
		player = player,
		score = 0,
		stratPlaying = t,
	}
	table.insert(playingPlayers, _arg0)
end
local function removePlayer(player)
	-- ▼ ReadonlyArray.findIndex ▼
	local _callback = function(v)
		return v.player == player
	end
	local _result = -1
	for _i, _v in playingPlayers do
		if _callback(_v, _i - 1, playingPlayers) == true then
			_result = _i - 1
			break
		end
	end
	-- ▲ ReadonlyArray.findIndex ▲
	local idx = _result
	table.remove(playingPlayers, idx + 1)
end
-- game loop
while true do
	--[[
		
		        round duration -> 2min
		        round cooldown -> 10sec
		
		        
		
		
		
		
		
		    
	]]
	task.wait(2)
end
-- network
-- todo: take player who clicked on play button
return nil
