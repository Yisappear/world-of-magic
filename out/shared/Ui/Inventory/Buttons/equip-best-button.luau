-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function EquipBestButton(props)
	return React.createElement("imagebutton", {
		Size = UDim2.fromScale(0.3, 0.1),
		Position = UDim2.fromScale(0.02, 0.92),
		Visible = true,
		Event = {
			MouseButton1Click = function() end,
		},
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Equip Best",
		Font = "FredokaOne",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
	}, React.createElement("uistroke", {
		Thickness = 1,
	})))
end
return {
	default = EquipBestButton,
}
