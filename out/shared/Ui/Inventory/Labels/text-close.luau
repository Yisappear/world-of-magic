-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function TextClose(props)
	return React.createElement("textlabel", {
		Position = UDim2.fromScale(0, -0.07),
		Size = UDim2.fromScale(0.45, 0.15),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
		Text = "Close",
		FontFace = Font.new("Ubuntu", Enum.FontWeight.Bold),
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextScaled = true,
	})
end
return {
	default = TextClose,
}
