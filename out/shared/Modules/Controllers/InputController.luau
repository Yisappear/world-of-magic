-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ContextActionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ContextActionService
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
-- private functions
local function onEquipWeapon()
	local function onClick(actionName, state, inputObject)
		if state == Enum.UserInputState.End then
			return nil
		end
		Network.Attack:FireServer()
	end
	local function onFirstAbility(actionName, state, inputObject)
		if state == Enum.UserInputState.End then
			return nil
		end
		Network.Ability:FireServer("first")
	end
	local function onSecondAbility(actionName, state, inputObject)
		if state == Enum.UserInputState.End then
			return nil
		end
		Network.Ability:FireServer("second")
	end
	ContextActionService:BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1)
	ContextActionService:BindAction("firstAbility", onFirstAbility, false, Enum.KeyCode.Z)
	ContextActionService:BindAction("secondAbility", onSecondAbility, false, Enum.KeyCode.X)
end
local function onUnequipWeapon()
	ContextActionService:UnbindAction("Attack")
	ContextActionService:UnbindAction("firstAbility")
	ContextActionService:UnbindAction("secondAbility")
end
onEquipWeapon()
return nil
