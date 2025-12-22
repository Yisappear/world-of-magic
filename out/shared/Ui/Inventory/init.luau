-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local MainFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "main-frame").default
local TextInventory = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Labels", "text-inventorymain").default
local CloseButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "close-button").default
local ContentFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "content-frame").default
local VoidSelectFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "voidselect-frame").default
local WeaponSelectFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "weaponselect-frame").default
local function App(props)
	-- hooks
	-- main frame
	local mainFrameVisible, mainFrame = React.useState(true)
	local changeMainFrameVisible = function()
		return mainFrame(function(v)
			return not v
		end)
	end
	-- void select frame
	local voidSelectFrameVisible, voidSelect = React.useState(true)
	local changeVoidSelectVisible = function()
		return voidSelect(function(v)
			return not v
		end)
	end
	-- select frame
	local selectFrameVisible, selectFrame = React.useState(true)
	local changeSelectVisible = function()
		return selectFrame(function(v)
			return not v
		end)
	end
	return React.createElement("screengui", {
		ResetOnSpawn = false,
	}, React.createElement(MainFrame, {
		visible = mainFrameVisible,
	}, React.createElement(TextInventory), React.createElement(CloseButton, {
		onClick = changeMainFrameVisible,
	}), React.createElement(ContentFrame, {
		onClick1 = changeVoidSelectVisible,
		onClick2 = changeSelectVisible,
	}), React.createElement(VoidSelectFrame, {
		visible = voidSelectFrameVisible,
	}), React.createElement(WeaponSelectFrame, {
		visible = selectFrameVisible,
		voidSelectFramVisible = voidSelect,
	})))
end
return {
	default = App,
}
