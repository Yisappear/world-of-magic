-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local TextEquipped = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Labels", "text-equipped").default
local EquippedItemButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "equipped-item-button").default
local function EquippedFrame(props)
	-- hooks
	local items, setItem = React.useState({})
	React.useEffect(function()
		local equipConnection = Network.EquipItemEvent.OnClientEvent:Connect(function(args)
			local item = args
			local function getIcon(itemType, name)
				if itemType == "Weapon" then
					local _result = ReplicatedStorage:FindFirstChild("Modules")
					if _result ~= nil then
						_result = _result:FindFirstChild("Configs")
						if _result ~= nil then
							_result = _result:FindFirstChild("Weapons")
							if _result ~= nil then
								_result = _result:FindFirstChild(name .. "Config")
							end
						end
					end
					local config = require(_result)
					local icon = config.icon
					return icon
				end
				if itemType == "Armore" then
					local config = ""
					local icon = ""
					return icon
				end
				return ""
			end
			setItem(function(prev)
				local _array = {}
				local _length = #_array
				local _prevLength = #prev
				table.move(prev, 1, _prevLength, _length + 1, _array)
				_length += _prevLength
				_array[_length + 1] = {
					uuid = item.uuid,
					name = item.name,
					itemType = item.itemType,
					icon = getIcon(item.itemType, item.name),
				}
				return _array
			end)
		end)
		local unequipConnction = Network.UnequipItemEvent.OnClientEvent:Connect(function(args)
			local item = args
			setItem(function(prev)
				-- ▼ ReadonlyArray.filter ▼
				local _newValue = {}
				local _callback = function(i)
					return i.uuid ~= item.uuid
				end
				local _length = 0
				for _k, _v in prev do
					if _callback(_v, _k - 1, prev) == true then
						_length += 1
						_newValue[_length] = _v
					end
				end
				-- ▲ ReadonlyArray.filter ▲
				return _newValue
			end)
		end)
		return function()
			equipConnection:Disconnect()
			unequipConnction:Disconnect()
		end
	end, {})
	local _exp = React.createElement(TextEquipped)
	local _exp_1 = React.createElement("uigridlayout", {
		CellPadding = UDim2.new(0, 5, 0, 5),
		CellSize = UDim2.new(0.2, 0, 1, 0),
	}, React.createElement("uiaspectratioconstraint"))
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#items)
	local _callback = function(button)
		return React.createElement(EquippedItemButton, {
			key = button.uuid,
			icon = button.icon,
			onClick = function()
				Network.SelectItemEvent:Fire(button)
			end,
		})
	end
	for _k, _v in items do
		_newValue[_k] = _callback(_v, _k - 1, items)
	end
	-- ▲ ReadonlyArray.map ▲
	return React.createElement("frame", {
		Size = UDim2.fromScale(1, 0.15),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
	}, _exp, React.createElement("frame", {
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Visible = true,
		ClipsDescendants = false,
	}, _exp_1, _newValue))
end
return {
	default = EquippedFrame,
}
