-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function EquippedItemButton(props)
	return React.createElement("imagebutton", {
		Image = props.icon,
		Event = {
			MouseButton1Click = function()
				props.onClick()
			end,
		},
	})
end
return {
	default = EquippedItemButton,
}
