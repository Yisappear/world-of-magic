-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function MainFrame(props)
	return React.createElement("frame", {
		Size = UDim2.fromScale(0.715, 0.615),
		Position = UDim2.fromScale(0.215, 0.2),
		BackgroundColor3 = Color3.fromRGB(242, 242, 242),
		Visible = props.visible,
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 25),
	}), React.createElement("uistroke", {
		Thickness = 2,
	}), props.children)
end
return {
	default = MainFrame,
}
