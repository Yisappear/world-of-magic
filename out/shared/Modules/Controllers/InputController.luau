-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ContextActionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ContextActionService
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
-- private functions
local function onEquip()
	local function onClick(actionName, state, inputObject)
		-- print(inputObject)
		Network.Attack:FireServer()
	end
	local function onAbility(actionName, state, inputObject)
		-- print(inputObject);
		Network.Ability:FireServer()
	end
	ContextActionService:BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1)
	ContextActionService:BindAction("Ability", onAbility, false, Enum.KeyCode.Z, Enum.KeyCode.X)
end
local function onUnequip()
	ContextActionService:UnbindAction("Attack")
	ContextActionService:UnbindAction("Ability")
end
onEquip()
return nil
