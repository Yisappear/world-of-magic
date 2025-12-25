-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local RunService = _services.RunService
local Workspace = _services.Workspace
local ReplicatedStorage = _services.ReplicatedStorage
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local getCharacterFromPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").getCharacterFromPlayer
local rewardForKill = TS.import(script, game:GetService("ServerStorage"), "Modules", "RewardService").rewardForKill
-- folders
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Content = Modules:FindFirstChild("Content")
local Weapons = Content:FindFirstChild("Weapons")
-- arrays
local projectiles = {}
-- private functions
local function damage(enemyData, player, config)
	if enemyData.humanoid.Health == 0 then
		return false
	end
	local isKill = false
	local currentHealth = enemyData.humanoid.Health
	local damage = currentHealth - (config.damage - enemyData.armore)
	local newHealth = math.max(damage, 0)
	enemyData.humanoid.Health = newHealth
	if newHealth == 0 then
		task.spawn(function()
			rewardForKill(player, 10 * config.rewardMult, enemyData.character.Name)
		end)
	end
	return isKill
end
local function cleanup(createTime, nodes)
	for _, object in projectiles do
		if object.createTime == createTime then
			-- ▼ ReadonlyArray.findIndex ▼
			local _callback = function(obj)
				return obj.createTime == createTime
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
			projectiles[idx + 1].model:Destroy()
			table.remove(projectiles, idx + 1)
		end
	end
	for _, i in nodes do
		i:Destroy()
	end
end
local function getPositionAtPath(nodes, distanceTraveled)
	local pDistance = 0
	for i = 2, #nodes do
		local p0 = nodes[i - 1].Position
		local p1 = nodes[i].Position
		local newPDistance = pDistance + (p1 - p0).Magnitude
		if newPDistance > distanceTraveled then
			local alpha = math.map(distanceTraveled, pDistance, newPDistance, 0, 1)
			return { false, CFrame.lookAlong(p0:Lerp(p1, alpha), p1 - p0) }
		end
		pDistance = newPDistance
	end
	local p0 = nodes[#nodes - 1].Position
	local p1 = nodes[#nodes].Position
	return { true, CFrame.lookAlong(p1, p1 - p0) }
end
local function onAbility(player, abilityKey)
	local createTime = Workspace:GetServerTimeNow()
	local weaponName = player:GetAttribute(GameConfig.WEAPON_ATTRIBUTE)
	if weaponName == nil then
		return nil
	end
	local configModule = require(Weapons:FindFirstChild(weaponName))
	local config = configModule.default
	if configModule == nil or config == nil then
		return nil
	end
	local model = Instance.new("Part")
	model.Parent = Workspace
	model.Position = Vector3.one
	model.Size = config.abilityZModel.Size
	model.CanCollide = false
	model.Transparency = 0.5
	model.Color = Color3.new(170, 0, 0)
	model.Anchored = true
	local speed = config.abilityZSpeed
	local nodes
	if abilityKey == "Z" then
		local _binding = config.abilityZ(player)
		local hasMove = _binding[1]
		local path = _binding[2]
		if hasMove == false then
			return nil
		end
		nodes = path
	end
	if nodes == nil then
		model:Destroy()
	end
	local _arg0 = {
		config = config,
		owner = player,
		createTime = createTime,
		model = model,
		speed = speed,
		nodes = nodes,
	}
	table.insert(projectiles, _arg0)
	-- const playerCharacter: Model = getCharacterFromPlayer(player);
	-- let isTouched: boolean = false;
	-- const connection = model.Touched.Connect(otherPart => {
	--     if ( isTouched === true || otherPart.Parent === playerCharacter  || otherPart.Parent === undefined ) return;
	--     isTouched = true;
	--     cleanup(createTime, nodes);
	--     const [isDamage, enemyData] = config.touchedEffectAttack(otherPart, player);
	--     if ( isDamage === true ) {
	--         damage(enemyData, player, config);
	--     }
	--     connection.Disconnect();
	-- })
end
local function onAttack(player)
	local createTime = Workspace:GetServerTimeNow()
	local weaponName = player:GetAttribute(GameConfig.WEAPON_ATTRIBUTE)
	if weaponName == nil then
		return nil
	end
	local configModule = require(Weapons:FindFirstChild(weaponName))
	local config = configModule.default
	if configModule == nil or config == nil then
		return nil
	end
	-- cooldown
	local _condition = player:GetAttribute(GameConfig.COOLDOWN)
	if _condition == nil then
		_condition = 0
	end
	local cooldown = _condition
	local lastWeapon = player:GetAttribute(GameConfig.LAST_WEAPON)
	if (createTime - cooldown) < config.cooldown and lastWeapon == weaponName then
		return nil
	end
	player:SetAttribute(GameConfig.COOLDOWN, createTime)
	player:SetAttribute(GameConfig.LAST_WEAPON, weaponName)
	local model = Instance.new("Part")
	model.Parent = Workspace
	model.Size = config.projectileModel.Size
	model.CanCollide = false
	model.Transparency = 0.5
	model.Color = Color3.new(170, 0, 0)
	model.Anchored = true
	local nodes = config.getPathAttack(player)
	local _arg0 = {
		config = config,
		owner = player,
		createTime = createTime,
		model = model,
		speed = config.projectileSpeed,
		nodes = nodes,
	}
	table.insert(projectiles, _arg0)
	-- touched event
	local playerCharacter = getCharacterFromPlayer(player)
	local isTouched = false
	local connection
	connection = model.Touched:Connect(function(otherPart)
		if isTouched == true or otherPart.Parent == playerCharacter or otherPart.Parent == nil then
			return nil
		end
		isTouched = true
		cleanup(createTime, nodes)
		local _binding = config.touchedEffectAttack(otherPart, player)
		local isDamage = _binding[1]
		local enemyData = _binding[2]
		if isDamage == true then
			damage(enemyData, player, config)
		end
		connection:Disconnect()
	end)
	-- client render
end
-- setup
RunService.Stepped:Connect(function()
	local p = {}
	local cfs = {}
	-- move projectiles
	for _, object in projectiles do
		if projectiles[1] == nil then
			return nil
		end
		if object.model.Parent ~= nil then
			local t = Workspace:GetServerTimeNow()
			local distanceTraveled = (t - object.createTime) * object.speed
			local _binding = getPositionAtPath(object.nodes, distanceTraveled)
			local finished = _binding[1]
			local cf = _binding[2]
			if finished == true then
				cleanup(object.createTime, object.nodes)
				object.config.touchedEffectAttack(object.model, object.owner)
			end
			local _model = object.model
			table.insert(p, _model)
			table.insert(cfs, cf)
		end
	end
	if p[1] == nil or cfs[1] == nil then
		return nil
	end
	Workspace:BulkMoveTo(p, cfs, Enum.BulkMoveMode.FireCFrameChanged)
end)
Network.AttackEvent.OnServerEvent:Connect(onAttack)
Network.AbilityEvent.OnServerEvent:Connect(function(player, args)
	if args == nil then
		return nil
	end
	local key = args
	onAbility(player, key)
end)
return nil
