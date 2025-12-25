-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function ArmoreItemButton(props)
	local ref = React.useRef()
	React.useEffect(function()
		local button = ref.current
		if button == nil then
			return nil
		end
		local connection = button:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			Network.UpdateWeaponFrameEvent:Fire(button.AbsoluteSize)
		end)
		return function()
			connection:Disconnect()
		end
	end, {})
	return React.createElement("imagebutton", {
		ref = ref,
		Image = props.icon,
		Event = {
			MouseButton1Click = function()
				props.onClick()
			end,
		},
	})
end
return {
	default = ArmoreItemButton,
}
