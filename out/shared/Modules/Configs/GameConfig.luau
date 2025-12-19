-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local server
if RunService:IsServer() == true then
	local data = {
		DATA_NAME = "unknown",
		DATA_TEMPLATE = {
			cash = 1000,
			inventory = {
				weapons = {},
				armores = {},
			},
		},
	}
	server = data
end
local default = {
	server = server,
	isServer = RunService:IsServer(),
	isStudio = RunService:IsStudio(),
	isClient = RunService:IsClient(),
	DATA_NAME = "unknown",
	DATA_TEMPLATE = {
		cash = 1000,
		inventory = {
			weapons = {},
			armores = {},
		},
	},
	WEAPON_ATTRIBUTE = "WEAPON_ATTRIBUTE",
	FIRE_STAFF = "FireStaff",
	CAN_HIT = "CAN_HIT",
	ARMORE_ATTRIBUTE = "ARMORE_ATTRIBUTE",
}
return {
	default = default,
}
