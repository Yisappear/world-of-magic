-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function CloseButton(props)
	return React.createElement("imagebutton", {
		Size = UDim2.fromScale(0.1, 0.15),
		Position = UDim2.fromScale(0.92, -0.02),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Visible = true,
		Event = {
			MouseButton1Click = function()
				props.onClick()
			end,
		},
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(1, 0.3),
		Position = UDim2.fromScale(0, 0.35),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Close",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(0, 0, 0),
	}))
end
return {
	default = CloseButton,
}
