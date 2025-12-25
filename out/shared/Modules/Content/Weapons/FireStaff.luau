-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
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
	projectileSpeed = 21,
	rewardMult = 1,
	getPathAttack = function(player)
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
		local _arg0_3 = lookVector * 20
		local node2Position = node1Position + _arg0_3
		local _exp_1 = lookVector * 5
		local _arg0_4 = up * (-4)
		local node3Position = node2Position + (_exp_1 + _arg0_4)
		local nodes = { createNode(node1Position), createNode(node2Position), createNode(node3Position) }
		return nodes
	end,
	touchedEffectAttack = function(otherPart, owner)
		if otherPart == nil then
			return { false, nil }
		end
		local ownerCharacter = getCharacterFromPlayer(owner)
		-- hitbox explosion
		local hitbox = Instance.new("Part")
		hitbox.Parent = Workspace
		hitbox.Size = Vector3.new(4, 4, 4)
		hitbox.Position = otherPart.Position
		hitbox.Color = Color3.fromRGB(170, 0, 0)
		hitbox.Transparency = 0.8
		hitbox.Anchored = true
		hitbox.CanCollide = false
		hitbox.CanTouch = false
		local overlapParams = OverlapParams.new()
		overlapParams.FilterType = Enum.RaycastFilterType.Exclude
		local parts = Workspace:GetPartsInPart(hitbox, overlapParams)
		if parts[1] == nil then
			return { false, nil }
		end
		for _, i in parts do
			if i.Parent ~= nil then
				local character = i.Parent
				if character == ownerCharacter then
					return { false, nil }
				end
				local humanoid = i.Parent:FindFirstChild("Humanoid")
				if humanoid ~= nil then
					local _condition = i.Parent:GetAttribute(GameConfig.ARMORE_ATTRIBUTE)
					if _condition == nil then
						_condition = 0
					end
					local armore = _condition
					local data = {
						character = character,
						humanoid = humanoid,
						armore = armore,
					}
					-- hitbox.Destroy();
					return { true, data }
				end
			end
		end
		-- hitbox.Destroy();
		return { false, nil }
	end,
}
return {
	default = default,
}
