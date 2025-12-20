-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ContextActionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ContextActionService
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function onEquip()
	local lastClick = 0
	local function onClick(actionName, state, inputObject)
		local t = os.clock()
		if (t - lastClick) < 0.5 then
			return nil
		end
		lastClick = t
		Network.AttackEvent:FireServer()
	end
	-- bind CAS
	ContextActionService:BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1)
end
local function onUnequip()
	-- unbind CAS
	ContextActionService:UnbindAction("Attack")
end
--TEST
onEquip()
task.wait(10)
print(`Unbind attack test`)
onUnequip()
-- setup
Network.EquipWeaponEvent.OnClientEvent:Connect(function(args)
	return onEquip()
end)
Network.UnequipWeaponEvent.OnClientEvent:Connect(function(args)
	return onUnequip()
end)
return nil
