-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ContextActionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ContextActionService
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
-- private functions
local function onEquipWeapon()
	local lastClick = 0
	local function onClick(actionName, state, inputObject)
		local t = os.clock()
		if (t - lastClick) < 0.5 then
			return nil
		end
		lastClick = t
		Network.AttackEvent:FireServer()
	end
	local function onAbilityZ(actionName, state, inputObject)
		Network.AbilityEvent:FireServer("Z")
	end
	local function onAbilityX(actionName, state, inputObject)
		Network.AbilityEvent:FireServer("X")
	end
	-- bind CAS
	ContextActionService:BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch)
	ContextActionService:BindAction("AbilityZ", onAbilityZ, false, Enum.KeyCode.Z)
	ContextActionService:BindAction("AbilityX", onAbilityX, false, Enum.KeyCode.X)
end
local function onUnequipWeapon()
	-- unbind CAS
	ContextActionService:UnbindAction("Attack")
	ContextActionService:UnbindAction("AbilityZ")
	ContextActionService:UnbindAction("AbilityX")
end
-- setup
Network.WeaponEquipEvent.OnClientEvent:Connect(onEquipWeapon)
Network.WeaponUnequipEvent.OnClientEvent:Connect(onUnequipWeapon)
return nil
