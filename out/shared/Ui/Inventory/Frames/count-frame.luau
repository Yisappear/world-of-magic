-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function CountFrame(props)
	return React.createElement("frame", {
		Size = UDim2.fromScale(0.4, 0.15),
		Position = UDim2.fromScale(0.515, -0.02),
		BackgroundColor3 = Color3.fromRGB(0, 191, 255),
		BackgroundTransparency = 0,
		Visible = true,
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("imagelabel", {
		Size = UDim2.fromScale(0.15, 0.8),
		Position = UDim2.fromScale(0.05, 0.1),
		Visible = true,
	}), React.createElement("imagelabel", {
		Size = UDim2.fromScale(0.15, 0.8),
		Position = UDim2.fromScale(0.55, 0.1),
		Visible = true,
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(0.3, 0.45),
		Position = UDim2.fromScale(0.2, 0.3),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = `0/10`,
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})), React.createElement("textlabel", {
		Size = UDim2.fromScale(0.3, 0.45),
		Position = UDim2.fromScale(0.7, 0.3),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = `0/10`,
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})))
end
return {
	default = CountFrame,
}
