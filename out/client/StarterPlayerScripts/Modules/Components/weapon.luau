-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
-- private functions
local function useUnequipAnimation()
	return nil
end
local function useEquipAnimation()
	return nil
end
local function loadWeapon(tool)
	if tool == nil then
		return nil
	end
	tool.Equipped:Connect(function()
		useEquipAnimation()
	end)
	tool.Unequipped:Connect(function()
		useUnequipAnimation()
	end)
	tool.Activated:Connect(function()
		GameConfig.attackEvent:FireServer(tool)
	end)
end
-- setup
GameConfig.newWeaponEvent.OnClientEvent:Connect(function(args)
	if args == nil then
		return nil
	end
	local tool = args
	if tool:IsA("Tool") == false then
		return nil
	end
	loadWeapon(tool)
end)
return nil
