-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local RunService = _services.RunService
local ReplicatedStorage = _services.ReplicatedStorage
-- constants
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Events = ReplicatedStorage:WaitForChild("Events")
local Weapons = Assets:FindFirstChild("Weapons")
local ObjectPoolBullets = Weapons:FindFirstChild("ObjectPoolBullets")
local MouseEvents = Events:FindFirstChild("MouseEvents")
local WeaponEvents = Events:FindFirstChild("WeaponEvents")
local InventoryEvents = Events:FindFirstChild("InventoryEvents")
-- variables
local server
local client
local isServer = RunService:IsServer()
local isClient = RunService:IsClient()
-- server
if isServer == true then
	local serverStorage = game:GetService("ServerStorage")
	local RewardEvents = serverStorage:FindFirstChild("RewardEvents")
	local object = {}
	server = object
end
-- client
if isClient == true then
	local object = {}
	client = object
end
-- setup
local default = {
	server = server,
	client = client,
	isServer = isServer,
	isClient = isClient,
	Assets = Assets,
	Weapons = Weapons,
	ObjectPoolBullets = ObjectPoolBullets,
	Events = Events,
	MouseEvents = MouseEvents,
	WeaponEvents = WeaponEvents,
	DATA_NAME = "unknown",
	PROFILE_TEMPLATE = {
		Cash = 1000,
		inventory = {
			weapons = {},
		},
	},
	BASE_WEAPON = "BaseWeapon",
	BASE_BULLET = "BaseBullet",
	WEAPON_STATE = "WEAPON_STATE",
	COOLDOWN = "COOLDOWN",
	newWeaponEvent = WeaponEvents:FindFirstChild("NewWeapon"),
	attackEvent = WeaponEvents:FindFirstChild("Attack"),
	newItemEvent = InventoryEvents:FindFirstChild("NewItemEvent"),
	deleteItemEvent = InventoryEvents:FindFirstChild("DeleteItemEvent"),
	updateInventoryEvent = InventoryEvents:FindFirstChild("UpdateInventoryEvent"),
	equipItemEvent = InventoryEvents:FindFirstChild("EquipItemEvent"),
	unequipItem = InventoryEvents:FindFirstChild("unequipItemEvent"),
	getEquippedItemsEvent = InventoryEvents:FindFirstChild("GetEquippedItemsEvents"),
	getMousePositionOnScreenEvent = MouseEvents:FindFirstChild("GetMousePositionOnScreenEvent"),
	getMouseHitInWolrdEvent = MouseEvents:FindFirstChild("GetMouseHitInWolrdEvent"),
	getMousePositionInWorldEvent = MouseEvents:FindFirstChild("GetMousePositionInWorldEvent"),
	getCameraRay = MouseEvents:FindFirstChild("GetCameraRayEvent"),
}
return {
	default = default,
}
