-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local default = {
	isServer = RunService:IsServer(),
	isStudio = RunService:IsStudio(),
	isClient = RunService:IsClient(),
}
return {
	default = default,
}
