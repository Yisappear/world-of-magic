-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local getCharacterFromPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").getCharacterFromPlayer
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local createNode = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").createNode
-- folders
local Assets = ReplicatedStorage:WaitForChild("Assets")
local WeaponAssets = Assets:FindFirstChild("WeaponAssets")
-- constants
local fireStaff = WeaponAssets:FindFirstChild("FireStaff")
local fireball = WeaponAssets:FindFirstChild("Fireball")
local default = {
	model = fireStaff,
	damage = 20,
	cooldown = 1.5,
	animation = "",
	icon = "",
	projectileModel = fireball,
	projectileSpeed = 5,
	getPath = function(player)
		local playerCharacter = getCharacterFromPlayer(player)
		local playerHumanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
		local position = playerHumanoidRootPart.Position
		local lookVector = playerHumanoidRootPart.CFrame.LookVector
		local right = playerHumanoidRootPart.CFrame.RightVector
		local up = playerHumanoidRootPart.CFrame.UpVector
		local _arg0 = lookVector * 2
		local _exp = position + _arg0
		local _arg0_1 = right * 2
		local _arg0_2 = up * 1
		local node1Position = _exp + _arg0_1 + _arg0_2
		local _arg0_3 = lookVector * 15
		local node2Position = node1Position + _arg0_3
		local _exp_1 = lookVector * 5
		local _arg0_4 = up * (-4)
		local node3Position = node2Position + (_exp_1 + _arg0_4)
		local node1 = createNode(node1Position)
		local node2 = createNode(node2Position)
		local node3 = createNode(node3Position)
		local nodes = { node1, node2, node3 }
		print(nodes)
		return nodes
	end,
	moveAtPath = function(distanceTraveled, nodes)
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
	end,
	touchedEffect = function(otherPart)
		-- explosion
		local enemyHumanoid = otherPart:FindFirstChild("Humanoid")
		if enemyHumanoid == nil then
			return { false, nil }
		end
		local _condition = otherPart:GetAttribute(GameConfig.ARMORE_ATTRIBUTE)
		if _condition == nil then
			_condition = 0
		end
		local enemyArmore = _condition
		local data = {
			humanoid = enemyHumanoid,
			armore = enemyArmore,
		}
		return { true, data }
	end,
}
return {
	default = default,
}
