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
	local changeVisible = function()
		return equipButton(function(v)
			return not v
		end)
	end
	-- vision
	local frameVision, selectFrame = React.useState(false)
	local changeFrameVision = function()
		return selectFrame(function(v)
			return not v
		end)
	end
	local refExample = {
		uuid = "aaa",
		name = "FireStaff",
		itemType = "Weapon",
	}
	local dataRef = React.useRef(refExample)
	local function onUnequip()
		Network.UnequipItemEvent:FireServer(dataRef.current)
	end
	local function onSell()
		Network.DelItemEvent:FireServer(dataRef.current)
	end
	React.useEffect(function()
		Network.SelectItemEvent.Event:Connect(function(args)
			selectFrame(true)
			if args == nil then
				return nil
			end
			local data = args
			dataRef.current = data
			equipButton(true)
			local equipped = Network.IsEquipped:InvokeServer(data.uuid)
			if equipped == true then
				equipButton(false)
			end
		end)
		Network.CloseInventoryEvent.Event:Connect(function()
			if frameVision == false then
				return nil
			end
			selectFrame(false)
			if equipVision == false then
				equipButton(true)
			end
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
			dataRef.current = refExample
		end,
		visible = equipVision,
	}), React.createElement(UnequipButton, {
		onClick = function()
			onUnequip()
		end,
		visible = not equipVision,
	}), React.createElement(SellButton, {
		onClick = function()
			onSell()
		end,
		visible = true,
	})))
end
return {
	default = WeaponSelectFrame,
}
