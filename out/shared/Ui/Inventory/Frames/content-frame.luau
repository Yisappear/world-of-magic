-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local EquippedFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "equipped-frame").default
local InventoryFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "inventory-frame").default
local function ContentFrame(props)
	return React.createElement("frame", {
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = true,
	}, React.createElement("scrollingframe", {
		Position = UDim2.fromScale(0, 0.1),
		Size = UDim2.fromScale(1, 0.9),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
	}, React.createElement("uilistlayout"), React.createElement("uipadding"), React.createElement(EquippedFrame, {
		onClick1 = props.onClick1,
		onClick2 = props.onClick2,
	}), React.createElement(InventoryFrame, {
		onClick1 = props.onClick1,
		onClick2 = props.onClick2,
	})))
end
return {
	default = ContentFrame,
}
