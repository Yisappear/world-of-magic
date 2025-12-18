-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function UnequipButton(props)
	return React.createElement("textbutton", {
		Position = UDim2.fromScale(0.05, 0.7),
		Size = UDim2.fromScale(0.9, 0.1),
		BackgroundColor3 = Color3.fromRGB(170, 0, 0),
		BackgroundTransparency = 0,
		Visible = props.visible,
		ClipsDescendants = false,
		Text = "Unequip",
		FontFace = Font.new("Ubuntu", Enum.FontWeight.Bold),
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextScaled = true,
		Event = {
			MouseButton1Click = function()
				props.onClick()
			end,
		},
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 10),
	}), React.createElement("uistroke", {
		Thickness = 2,
	}))
end
return {
	default = UnequipButton,
}
