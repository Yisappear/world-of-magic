-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local RunService = _services.RunService
local Workspace = _services.Workspace
local ReplicatedStorage = _services.ReplicatedStorage
local Players = _services.Players
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
local function notification()
	Network.RenderEvent:FireAllClients()
end
local function rewardPerKill(player)
end
local function isDamageAndKill(enemyHumanoid, enemyArmore, weaponDamage)
	local isDamage = false
	local isKill = false
	local currentHealth = enemyHumanoid.Health
	local damage = currentHealth - (weaponDamage - enemyArmore)
	local newHealth = math.max(damage, 0)
	enemyHumanoid.Health = newHealth
	isDamage = true
	if newHealth == 0 then
		isKill = true
		return { isDamage, isKill }
	end
	return { isDamage, isKill }
end
local function cleanup(model)
	for _, object in projectiles do
		if object.model == model then
			-- ▼ ReadonlyArray.findIndex ▼
			local _callback = function(obj)
				return obj.model == model
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
local function getServerProjectile(projectile)
	local part = Instance.new("Part")
	part.Parent = Workspace
	part.Size = projectile.Size
	part.CanCollide = false
	part.Transparency = 0.5
	return part
end
local function onAttack(player)
	print("onAttack")
	local _condition = player:GetAttribute(GameConfig.WEAPON_ATTRIBUTE)
	if _condition == nil then
		_condition = GameConfig.FIRE_STAFF
	end
	local weaponName = _condition
	local configName = `{weaponName}` .. "Config"
	local configModule = require(WeaponConfigs:FindFirstChild(configName))
	local config = configModule.default
	local model = getServerProjectile(config.projectileModel)
	local cf = config.getStartPosition(player)
	local startPosition = cf.Position
	local direction = cf.LookVector
	local playerCharacter = getCharacterFromPlayer(player)
	local _arg0 = {
		config = config,
		owner = player,
		createTime = Workspace:GetServerTimeNow(),
		model = model,
		speed = config.projectileSpeed,
		startPosition = startPosition,
		direction = direction,
	}
	table.insert(projectiles, _arg0)
	model:SetAttribute(GameConfig.CAN_HIT, true)
	model.Touched:Connect(function(otherPart)
		if otherPart.Parent == playerCharacter or model.Name == otherPart.Name or model:GetAttribute(GameConfig.CAN_HIT) == false then
			return nil
		end
		model:SetAttribute(GameConfig.CAN_HIT, false)
		cleanup(model)
		local enemyCharacter = otherPart.Parent
		local _result = enemyCharacter
		if _result ~= nil then
			_result = _result:FindFirstChild("Humanoid")
		end
		local enemyHumanoid = _result
		local enemyPlayer = Players:GetPlayerFromCharacter(enemyCharacter)
		local enemyArmore = 0
		if enemyHumanoid == nil then
			return nil
		end
		if enemyPlayer ~= nil then
			local _condition_1 = enemyPlayer:GetAttribute(GameConfig.ARMORE_ATTRIBUTE)
			if _condition_1 == nil then
				_condition_1 = 0
			end
			enemyArmore = _condition_1
		end
		task.spawn(function()
			local _binding = isDamageAndKill(enemyHumanoid, enemyArmore, config.damage)
			local isDamage = _binding[1]
			local isKill = _binding[2]
			if isDamage == false then
				warn(`isDamage, got false`)
			end
			if isKill == true then
				rewardPerKill(player)
			end
		end)
	end)
	notification()
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
			local cf = object.config.getMovePosition(object.createTime, object.speed, object.startPosition, object.direction)
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
Network.AttackEvent.OnServerEvent:Connect(function(player, args)
	return onAttack(player)
end)
return nil
