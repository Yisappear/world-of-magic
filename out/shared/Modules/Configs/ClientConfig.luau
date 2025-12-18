-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local RunService = _services.RunService
if RunService:IsClient() == false then
	error("don't client??")
end
local player = Players.LocalPlayer
local default = {
	LOCAL_PLAYER = player,
	USER_ID = player.UserId,
	PLAYER_GUI = player:WaitForChild("PlayerGui"),
	PLAYER_SCRIPTS = player:FindFirstChild("PlayerScripts"),
	GET_CHARACTER = function()
		return player.Character or (player.CharacterAdded:Wait())
	end,
}
return {
	default = default,
}
