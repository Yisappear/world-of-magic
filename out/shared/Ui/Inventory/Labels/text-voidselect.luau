-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function TextVoidSelect(props)
	return React.createElement("textlabel", {
		Position = UDim2.fromScale(0, 0.3),
		Size = UDim2.fromScale(1, 0.4),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
		Text = "Select any item",
		FontFace = Font.new("Ubuntu", Enum.FontWeight.Bold),
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextScaled = true,
	})
end
return {
	default = TextVoidSelect,
}
