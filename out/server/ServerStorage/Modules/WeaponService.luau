-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Workspace = _services.Workspace
local RunService = _services.RunService
local ReplicatedStorage = _services.ReplicatedStorage
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local BasicStaff = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Content", "Weapons", "BasicStaff").default
local getPlayerStruct = TS.import(script, game:GetService("ServerStorage"), "Modules", "Player").getPlayerStruct
local getCharacterFromPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").getCharacterFromPlayer
-- types
-- module logic
local projectiles = {}
-- private functions
local function getPositionAtPath(treveledDistance, nodes)
	local sektor = 0
	for i = 2, #nodes do
		local p0 = nodes[i - 1].Position
		local p1 = nodes[i].Position
		local newSektor = sektor + (p0 - p1).Magnitude
		if newSektor > treveledDistance then
			local alpha = math.map(treveledDistance, sektor, newSektor, 0, 1)
			return { false, CFrame.lookAlong(p0:Lerp(p1, alpha), p1 - p0) }
		end
		sektor = newSektor
	end
	local p0 = nodes[#nodes - 1].Position
	local p1 = nodes[#nodes].Position
	return { true, CFrame.lookAlong(p1, p1 - p0) }
end
local function damageToEnemy(humanoid, damage)
	local hlth = humanoid.Health - damage
	local newHealth = math.max(hlth, 0)
	humanoid.Health = newHealth
end
local function getWeaponConfig(player)
	local playerStruct = getPlayerStruct(player)
	if not playerStruct then
		player:Kick("Game end. :P")
		return nil
	end
	local inventory = playerStruct.data.inventory
	local equipped = inventory.equipped
	local weaponName = ""
	for _, i in equipped do
		if i.itemType == "Weapon" then
			weaponName = i.itemName
		end
	end
	local _result = ReplicatedStorage:FindFirstChild("Modules")
	if _result ~= nil then
		_result = _result:FindFirstChild("Contens")
		if _result ~= nil then
			_result = _result:FindFirstChild("Weapons")
			if _result ~= nil then
				_result = _result:FindFirstChild(weaponName)
			end
		end
	end
	local module = require(_result)
	if not module then
		return " config doesn't exist "
	end
	local config = module.default
	return config
end
local function onAttack(player)
	local t = Workspace:GetServerTimeNow()
	-- debug get basic
	local damage = BasicStaff.damage
	local speed = BasicStaff.speed
	local model = BasicStaff.projectileModel:Clone()
	model.Parent = Workspace
	model.Color = Color3.fromRGB(220, 0, 0)
	local nodes = BasicStaff:getNodesAttack(player)
	-- create object for movement
	local _arg0 = {
		createTime = t,
		speed = speed,
		model = model,
		nodes = nodes,
	}
	table.insert(projectiles, _arg0)
	local ownerCharacter = getCharacterFromPlayer(player)
	local hasTouched = false
	local connection
	connection = model.Touched:Connect(function(otherPart)
		if hasTouched then
			return nil
		end
		if otherPart.Parent == ownerCharacter then
			return nil
		end
		hasTouched = true
		-- cleanup
		-- ▼ ReadonlyArray.findIndex ▼
		local _callback = function(v)
			return v.createTime == t
		end
		local _result = -1
		for _i, _v in projectiles do
			if _callback(_v, _i - 1, projectiles) == true then
				_result = _i - 1
				break
			end
		end
		-- ▲ ReadonlyArray.findIndex ▲
		local idx = _result
		table.remove(projectiles, idx + 1)
		model:Destroy()
		local enemyCharacter = otherPart.Parent
		local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")
		if enemyCharacter and enemyHumanoid then
			damageToEnemy(enemyHumanoid, damage)
		end
		connection:Disconnect()
		return nil
	end)
end
local function onAbility(player, keyword)
	local t = Workspace:GetServerTimeNow()
	-- get config from profile data equipped items
	local hasNodes = false
	local nodes
	local touchedFunction
	if keyword == "first" then
		local _binding = BasicStaff:firstAbility(player)
		local has = _binding[1]
		local list = _binding[2]
		local func = _binding[3]
		hasNodes = has
		nodes = list
		touchedFunction = func
	end
	if keyword == "second" then
		local _binding = BasicStaff:secondAbility(player)
		local has = _binding[1]
		local list = _binding[2]
		local func = _binding[3]
		hasNodes = has
		nodes = list
		touchedFunction = func
	end
	print(hasNodes)
	if not hasNodes then
		return nil
	end
	-- debug get basic
	local damage = BasicStaff.firstAbilityDamage
	local speed = BasicStaff.firstAbilitySpeed
	local model = BasicStaff.firstAbilityProjectileModel:Clone()
	model.Parent = Workspace
	model.Color = Color3.fromRGB(220, 0, 0)
	-- object for movement
	local _arg0 = {
		createTime = t,
		speed = speed,
		model = model,
		nodes = nodes,
	}
	table.insert(projectiles, _arg0)
	local ownerCharacter = getCharacterFromPlayer(player)
	local hasTouched = false
	local connection
	connection = model.Touched:Connect(function(otherPart)
		if hasTouched then
			return nil
		end
		if otherPart.Parent == ownerCharacter then
			return nil
		end
		hasTouched = true
		-- cleanup
		-- ▼ ReadonlyArray.findIndex ▼
		local _callback = function(v)
			return v.createTime == t
		end
		local _result = -1
		for _i, _v in projectiles do
			if _callback(_v, _i - 1, projectiles) == true then
				_result = _i - 1
				break
			end
		end
		-- ▲ ReadonlyArray.findIndex ▲
		local idx = _result
		table.remove(projectiles, idx + 1)
		model:Destroy()
		local _binding = touchedFunction(otherPart)
		local isTouchEnemy = _binding[1]
		local enemyHumanoid = _binding[2]
		if isTouchEnemy and enemyHumanoid then
			damageToEnemy(enemyHumanoid, damage)
		end
		connection:Disconnect()
		return nil
	end)
end
-- setup
RunService.Stepped:Connect(function()
	local t = Workspace:GetServerTimeNow()
	local parts = {}
	local cfs = {}
	-- loop for moving parts
	for _, i in projectiles do
		local treveledDistance = (t - i.createTime) * i.speed
		local _binding = getPositionAtPath(treveledDistance, i.nodes)
		local isFinished = _binding[1]
		local cframe = _binding[2]
		if isFinished then
			-- cleanup
			-- ▼ ReadonlyArray.findIndex ▼
			local _callback = function(v)
				return v.createTime == i.createTime
			end
			local _result = -1
			for _i, _v in projectiles do
				if _callback(_v, _i - 1, projectiles) == true then
					_result = _i - 1
					break
				end
			end
			-- ▲ ReadonlyArray.findIndex ▲
			local idx = _result
			table.remove(projectiles, idx + 1)
			i.model:Destroy()
			continue
		end
		local _model = i.model
		table.insert(parts, _model)
		table.insert(cfs, cframe)
	end
	if not parts[1] and not cfs[1] then
		return nil
	end
	Workspace:BulkMoveTo(parts, cfs, Enum.BulkMoveMode.FireCFrameChanged)
end)
-- network
Network.Attack.OnServerEvent:Connect(onAttack)
Network.Ability.OnServerEvent:Connect(function(player, args)
	if not (args ~= 0 and args == args and args ~= "" and args) then
		return nil
	end
	local data = args
	onAbility(player, data)
end)
return nil
