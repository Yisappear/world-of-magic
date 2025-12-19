-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ContextActionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ContextActionService
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function renderWeapon()
end
local function onEquip(name)
	local function onClick()
		print(`onClick`)
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
onEquip("")
return nil
