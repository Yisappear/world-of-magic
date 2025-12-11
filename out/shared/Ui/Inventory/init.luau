-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
-- import { changeMainFrameVisbile } from "./hooks";
local MainFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "main-frame").default
local CloseButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "close-button").default
local EquipBestButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "equip-best-button").default
local TextFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "text-frame").default
local CountFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "count-frame").default
local SelectFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Frames", "select-frame").default
-- types
-- hooks
-- function changeMainFrameVisbile() {
--     const [mVisible, changeState] = React.useState(false);
--     const changeMVisible = () => changeState((v) => !v);
--     return $tuple(mVisible, changeMVisible);
-- }
local function App(props)
	-- hooks
	local mVisible, changeState = React.useState(true)
	local changeMVisible = function()
		return changeState(function(v)
			return not v
		end)
	end
	return React.createElement("screengui", {
		ResetOnSpawn = false,
	}, React.createElement(MainFrame, {
		visible = mVisible,
	}, React.createElement(CloseButton, {
		onClick = changeMVisible,
	}), React.createElement(EquipBestButton, {
		onClick = changeMVisible,
	}), React.createElement(TextFrame), React.createElement(CountFrame), React.createElement(SelectFrame, {
		voidSelect = true,
		itemSelect = false,
	})))
end
return {
	default = App,
}
