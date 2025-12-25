-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local TextInventoryContent = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Labels", "text-inventorycontent").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local WeaponItemButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "weapon-item-button").default
local ArmoreItemButton = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory", "Buttons", "armore-item-button").default
local function InventoryFrame(props)
	-- hooks
	local armores, setArmore = React.useState({})
	local weapons, setWeapon = React.useState({})
	React.useEffect(function()
		local addConnection = Network.NewItemEvent.OnClientEvent:Connect(function(args)
			local item = args
			local function getIcon(itemType, name)
				if itemType == "Weapon" then
					local _result = ReplicatedStorage:FindFirstChild("Modules")
					if _result ~= nil then
						_result = _result:FindFirstChild("Content")
						if _result ~= nil then
							_result = _result:FindFirstChild("Weapons")
							if _result ~= nil then
								_result = _result:FindFirstChild(name)
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
			if item.itemType == "Weapon" then
				setWeapon(function(prev)
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
			end
			if item.itemType == "Armore" then
				setArmore(function(prev)
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
			end
		end)
		local delConnection = Network.DelItemEvent.OnClientEvent:Connect(function(args)
			local item = args
			if item.itemType == "Weapon" then
				setWeapon(function(prev)
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
			end
			if item.itemType == "Armore" then
				setArmore(function(prev)
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
			end
		end)
		return function()
			addConnection:Disconnect()
			delConnection:Disconnect()
		end
	end, {})
	local _exp = React.createElement(TextInventoryContent)
	local _exp_1 = React.createElement("uigridlayout", {
		CellPadding = UDim2.new(0, 5, 0, 5),
		CellSize = UDim2.new(1 / 5, 0, 1, 0),
	}, React.createElement("uiaspectratioconstraint"))
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#weapons)
	local _callback = function(button)
		return React.createElement(WeaponItemButton, {
			key = button.uuid,
			icon = button.icon,
			onClick = function()
				local itemData = {
					uuid = button.uuid,
					name = button.name,
					itemType = button.itemType,
				}
				Network.SelectItemEvent:Fire(itemData)
			end,
		})
	end
	for _k, _v in weapons do
		_newValue[_k] = _callback(_v, _k - 1, weapons)
	end
	-- ▲ ReadonlyArray.map ▲
	-- ▼ ReadonlyArray.map ▼
	local _newValue_1 = table.create(#armores)
	local _callback_1 = function(button)
		return React.createElement(ArmoreItemButton, {
			key = button.uuid,
			icon = button.icon,
			onClick = function()
				local itemData = {
					uuid = button.uuid,
					name = button.name,
					itemType = button.itemType,
				}
				Network.SelectItemEvent:Fire(itemData)
			end,
		})
	end
	for _k, _v in armores do
		_newValue_1[_k] = _callback_1(_v, _k - 1, armores)
	end
	-- ▲ ReadonlyArray.map ▲
	return React.createElement("frame", {
		Size = UDim2.fromScale(1, 1),
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
	}, _exp_1, _newValue, _newValue_1))
end
return {
	default = InventoryFrame,
}
