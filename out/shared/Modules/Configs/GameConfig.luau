-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local default = {
	isServer = RunService:IsServer(),
	isClient = RunService:IsClient(),
	isStudio = RunService:IsStudio(),
	dataName = "unknown",
	dataTemplate = {
		cash = 333,
		max_items = 7,
		inventory = {
			equipped = { {
				uuid = ":P",
				itemType = ":P",
				itemName = ":P",
				equipped = false,
			} },
			unequipped = { {
				uuid = "",
				itemType = "",
				itemName = "",
				equipped = false,
			} },
		},
	},
}
return {
	default = default,
}
