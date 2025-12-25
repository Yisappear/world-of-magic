-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function WeaponItemButton(props)
	local stateVector, changeVector = React.useState(Vector2.new(76, 76))
	React.useEffect(function()
		local connection = Network.UpdateWeaponFrameEvent.Event:Connect(function(args)
			if args == nil then
				return nil
			end
			local aVector = args
			local Value = aVector.X * 2
			changeVector(Vector2.new(Value, Value))
		end)
		return function()
			connection:Disconnect()
		end
	end, {})
	return React.createElement("imagebutton", {
		Image = props.icon,
		Event = {
			MouseButton1Click = function()
				props.onClick()
			end,
		},
	}, React.createElement("uisizeconstraint", {
		MinSize = stateVector,
	}))
end
return {
	default = WeaponItemButton,
}
