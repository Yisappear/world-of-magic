-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local function SelectFrame(props)
	return React.createElement("frame", {
		Size = UDim2.fromScale(0.25, 0.8),
		Position = UDim2.fromScale(0.735, 0.15),
		BackgroundColor3 = Color3.fromRGB(0, 191, 255),
		BackgroundTransparency = 0,
		Visible = true,
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = props.voidSelect,
	}, React.createElement("textlabel", {
		Size = UDim2.fromScale(0.8, 0.2),
		Position = UDim2.fromScale(0.1, 0.35),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Select an item",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(0, 0, 0),
	})), React.createElement("frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = props.itemSelect,
	}, React.createElement("imagelabel", {
		Size = UDim2.fromScale(0.7, 0.37),
		Position = UDim2.fromScale(0.15, 0.09),
		Visible = true,
		Image = "",
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(0.7, 0.1),
		Position = UDim2.fromScale(0.15, 0.02),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Name",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})), React.createElement("textlabel", {
		Size = UDim2.fromScale(0.4, 0.1),
		Position = UDim2.fromScale(0.02, 0.47),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Damage:",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})), React.createElement("textlabel", {
		Size = UDim2.fromScale(0.4, 0.1),
		Position = UDim2.fromScale(0.02, 0.47),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Armore:",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})), React.createElement("imagebutton", {
		Size = UDim2.fromScale(0.9, 0.1),
		Position = UDim2.fromScale(0.05, 0.72),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Visible = true,
		Event = {
			MouseButton1Click = function() end,
		},
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 7),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(1, 0.8),
		Position = UDim2.fromScale(0, 0.1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Equip",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	}))), React.createElement("imagebutton", {
		Size = UDim2.fromScale(0.9, 0.1),
		Position = UDim2.fromScale(0.05, 0.84),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Visible = true,
		Event = {
			MouseButton1Click = function() end,
		},
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 7),
	}), React.createElement("uistroke", {
		Thickness = 1,
	}), React.createElement("textlabel", {
		Size = UDim2.fromScale(1, 0.8),
		Position = UDim2.fromScale(0, 0.1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		Text = "Delete",
		Font = "FredokaOne",
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}, React.createElement("uistroke", {
		Thickness = 1,
	})))))
end
return {
	default = SelectFrame,
}
