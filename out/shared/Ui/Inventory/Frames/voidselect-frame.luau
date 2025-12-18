-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local TextVoidSelect = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Labels", "text-voidselect").default
local function VoidSelectFrame(props)
	return React.createElement("frame", {
		Position = UDim2.fromScale(1.05, 0),
		Size = UDim2.fromScale(0.5, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.6,
		Visible = props.visible,
		ClipsDescendants = false,
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 3,
	}), React.createElement(TextVoidSelect))
end
return {
	default = VoidSelectFrame,
}
