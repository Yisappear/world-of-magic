-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- shared config
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
-- constants
local baseWeapon = GameConfig.Weapons:FindFirstChild(GameConfig.BASE_WEAPON)
local baseBullet = GameConfig.Weapons:FindFirstChild(GameConfig.BASE_BULLET)
local default = {
	model = baseWeapon,
	bullet = baseBullet,
	bulletSpeed = 100,
	damage = 20,
	cooldown = 1,
	range = 50,
	attackAnimation = "",
	equipAnimation = "",
	unequipAnimation = "",
}
return {
	default = default,
}
