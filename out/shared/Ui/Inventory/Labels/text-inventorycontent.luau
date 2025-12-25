-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function TextInventoryContent(props)
	return React.createElement("textlabel", {
		Position = UDim2.fromScale(0.37, -0.05),
		Size = UDim2.fromScale(0.25, 0.04),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
		Text = "Inventory",
		Font = "Highway",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
	}, React.createElement("uistroke", {
		Thickness = 2,
		Color = Color3.fromRGB(190, 190, 190),
	}))
end
return {
	default = TextInventoryContent,
}
