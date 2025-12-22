-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local RunService = _services.RunService
local Workspace = _services.Workspace
local ReplicatedStorage = _services.ReplicatedStorage
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
local getCharacterFromPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").getCharacterFromPlayer
-- folders
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Configs = Modules:FindFirstChild("Configs")
local WeaponConfigs = Configs:FindFirstChild("Weapons")
-- constants
local projectiles = {}
-- private functions
local function isDamageKill(enemyHumanoid, enemyArmore, weaponDamage)
	if enemyHumanoid.Health == 0 then
		return false
	end
	local isDamage = false
	local isKill = false
	local currentHealth = enemyHumanoid.Health
	local damage = currentHealth - (weaponDamage - enemyArmore)
	local newHealth = math.max(damage, 0)
	enemyHumanoid.Health = newHealth
	isDamage = true
	if newHealth == 0 then
		isKill = true
		return isKill
	end
	return isKill
end
local function cleanup(createTime)
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
end
local function getHitbox(projectile)
	local part = Instance.new("Part")
	part.Parent = Workspace
	part.Size = projectile.Size
	part.CanCollide = false
	part.Transparency = 0.5
	part.Color = Color3.new(170, 0, 0)
	part.Anchored = true
	return part
end
local function onAttack(player)
	local createTime = Workspace:GetServerTimeNow()
	local _condition = player:GetAttribute(GameConfig.WEAPON_ATTRIBUTE)
	if _condition == nil then
		_condition = GameConfig.FIRE_STAFF
	end
	local weaponName = _condition
	local configModule = require(WeaponConfigs:FindFirstChild(`{weaponName}` .. "Config"))
	local config = configModule.default
	if configModule == nil or config == nil then
		return nil
	end
	-- cooldown
	local _condition_1 = player:GetAttribute(GameConfig.COOLDOWN)
	if _condition_1 == nil then
		_condition_1 = 0
	end
	local cooldown = _condition_1
	local lastWeapon = player:GetAttribute(GameConfig.LAST_WEAPON)
	if (createTime - cooldown) < config.cooldown and lastWeapon == weaponName then
		return nil
	end
	player:SetAttribute(GameConfig.COOLDOWN, createTime)
	player:SetAttribute(GameConfig.LAST_WEAPON, weaponName)
	-- create hitbox
	local model = getHitbox(config.projectileModel)
	local nodes = config.getPath(player)
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
		if otherPart.Parent == playerCharacter or otherPart.Parent == nil then
			return nil
		end
		isTouched = true
		cleanup(createTime)
		local _binding = config.touchedEffect(otherPart.Parent)
		local isDamage = _binding[1]
		local enemyData = _binding[2]
		if isDamage == true then
			local isKill = isDamageKill(enemyData.humanoid, enemyData.armore, config.damage)
			if isKill == true then
				task.spawn(function()
					-- reward
				end)
			end
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
			local _binding = object.config.moveAtPath(distanceTraveled, object.nodes)
			local finished = _binding[1]
			local cf = _binding[2]
			if finished == true then
				cleanup(object.createTime)
				object.config.touchedEffect(object.model)
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
return nil
