-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local default = {
	isServer = RunService:IsServer(),
	isStudio = RunService:IsStudio(),
	isClient = RunService:IsClient(),
	DATA_NAME = "unknown",
	DATA_TEMPLATE = {
		cash = 333,
		max_items = 7,
		inventory = {},
		settings = {},
	},
	COOLDOWN = "COOLDOWN",
	COOLDOWN_ABILITY = "COOLDOWN_ABILITY",
	LAST_WEAPON = "LAST_WEAPON",
	WEAPON_ATTRIBUTE = "WEAPON_ATTRIBUTE",
	FIRE_STAFF = "FireStaff",
	ARMORE_ATTRIBUTE = "ARMORE_ATTRIBUTE",
}
return {
	default = default,
}
