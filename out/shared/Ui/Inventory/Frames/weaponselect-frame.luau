-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local EquipButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "equip-button").default
local SellButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "sell-button").default
local UnequipButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "unequip-button").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local function WeaponSelectFrame(props)
	-- equip button
	local equipVision, equipButton = React.useState(true)
	-- vision
	local frameVision, selectFrame = React.useState(false)
	local refExample = {
		uuid = "aaa",
		name = "FireStaff",
		itemType = "Weapon",
	}
	local dataRef = React.useRef(refExample)
	React.useEffect(function()
		Network.SelectItemEvent.Event:Connect(function(args)
			if args == nil then
				return nil
			end
			local data = args
			dataRef.current = data
			props.voidSelectFramVisible(false)
			selectFrame(true)
			equipButton(true)
			local equipped = Network.IsEquipped:InvokeServer(data.uuid)
			if equipped == true then
				equipButton(false)
			end
		end)
		Network.CloseInventoryEvent.Event:Connect(function()
			selectFrame(false)
			props.voidSelectFramVisible(true)
			equipButton(true)
			dataRef.current = refExample
		end)
	end, { dataRef })
	return React.createElement("frame", {
		Position = UDim2.fromScale(1.05, 0),
		Size = UDim2.fromScale(0.5, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.6,
		Visible = frameVision,
		ClipsDescendants = false,
	}, React.createElement("uicorner", {
		CornerRadius = UDim.new(0, 15),
	}), React.createElement("uistroke", {
		Thickness = 3,
	}), React.createElement("frame", {
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = frameVision,
		ClipsDescendants = false,
	}, React.createElement(EquipButton, {
		onClick = function()
			Network.EquipItemEvent:FireServer(dataRef.current)
			local equipped = Network.IsEquipped:InvokeServer(dataRef.current.uuid)
			warn(equipped)
			if equipped == true then
				equipButton(false)
			end
		end,
		visible = equipVision,
	}), React.createElement(UnequipButton, {
		onClick = function()
			Network.UnequipItemEvent:FireServer(dataRef.current)
			local equipped = Network.IsEquipped:InvokeServer(dataRef.current.uuid)
			warn(equipped)
			if equipped == false then
				equipButton(true)
			end
		end,
		visible = not equipVision,
	}), React.createElement(SellButton, {
		onClick = function()
			Network.DelItemEvent:FireServer(dataRef.current)
		end,
		visible = true,
	})))
end
return {
	default = WeaponSelectFrame,
}
