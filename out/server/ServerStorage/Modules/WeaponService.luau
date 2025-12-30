-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Workspace = _services.Workspace
local RunService = _services.RunService
local BasicStaff = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Content", "Weapons", "BasicStaff").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
-- types
-- setup array for moving parts
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
	local function damageToEnemy(humanoid)
		local hlth = humanoid.Health - damage
		local newHealth = math.max(hlth, 0)
		print(newHealth)
		humanoid.Health = newHealth
	end
	local hasTouched = false
	local connection
	connection = model.Touched:Connect(function(otherPart)
		if hasTouched then
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
			damageToEnemy(enemyHumanoid)
		end
		connection:Disconnect()
		return nil
	end)
end
local function onAbility(player, keycode)
	local isMoving = BasicStaff:getNodesAbilityZ(player)
end
-- setup
RunService.Stepped:Connect(function()
	local t = Workspace:GetServerTimeNow()
	local parts = {}
	local cf = {}
	-- move loop
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
		table.insert(cf, cframe)
	end
	if not parts[1] and not cf[1] then
		return nil
	end
	Workspace:BulkMoveTo(parts, cf, Enum.BulkMoveMode.FireCFrameChanged)
end)
-- network
Network.Attack.OnServerEvent:Connect(onAttack)
-- Network.Ability.OnServerEvent.Connect((player, args) => { onAbility(player, args) });
return nil
