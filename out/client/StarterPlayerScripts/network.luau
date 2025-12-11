-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local _Mouse = TS.import(script, script.Parent, "Modules", "Utils", "Mouse")
local getMousePositionOnScreen = _Mouse.getMousePositionOnScreen
local getMousePositionInWorld = _Mouse.getMousePositionInWorld
local getMouseHitInWolrd = _Mouse.getMouseHitInWolrd
local getCameraRay = _Mouse.getCameraRay
-- setup
-- mouse
GameConfig.getMousePositionOnScreenEvent.OnClientInvoke = function()
	return getMousePositionOnScreen()
end
GameConfig.getMouseHitInWolrdEvent.OnClientInvoke = function()
	return getMouseHitInWolrd()
end
GameConfig.getMousePositionInWorldEvent.OnClientInvoke = function()
	return getMousePositionInWorld()
end
GameConfig.getCameraRay.OnClientInvoke = function()
	return getCameraRay()
end
--[[
	 inventory
	    Equip
	    Unequip
	    NewItem
	    DeletItem
	    UpdateInventory
	    EquippedItems
	
]]
return nil
