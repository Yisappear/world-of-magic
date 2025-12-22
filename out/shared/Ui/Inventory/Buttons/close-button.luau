-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function CloseButton(props)
	return React.createElement("imagebutton", {
		Position = UDim2.fromScale(0.87, -0.02),
		Size = UDim2.fromScale(0.15, 0.15),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0,
		Visible = true,
		ClipsDescendants = false,
		Event = {
			MouseButton1Click = function()
				props.onClick()
				Network.CloseInventoryEvent:Fire()
			end,
		},
	}, React.createElement("textlabel", {
		Position = UDim2.fromScale(0.2, 0.3),
		Size = UDim2.fromScale(0.65, 0.25),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
		Text = "Close",
		FontFace = Font.new("Ubuntu", Enum.FontWeight.Bold),
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextScaled = true,
	}))
end
return {
	default = CloseButton,
}
