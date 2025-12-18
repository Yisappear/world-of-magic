-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
local getCharacterFromPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").getCharacterFromPlayer
-- folders
local Assets = ReplicatedStorage:WaitForChild("Assets")
local WeaponAssets = Assets:FindFirstChild("WeaponAssets")
-- constants
local fireStaff = WeaponAssets:FindFirstChild("FireStaff")
local fireball = WeaponAssets:FindFirstChild("Fireball")
local default = {
	model = fireStaff,
	damage = 20,
	animation = "",
	projectileModel = fireball,
	projectileSpeed = 40,
	getStartPosition = function(player)
		local playerCharacter = getCharacterFromPlayer(player)
		local playerHumanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
		local lookVector = playerHumanoidRootPart.CFrame.LookVector
		local position = playerHumanoidRootPart.CFrame.Position
		local direction = position - lookVector
		local _vector3 = Vector3.new(3, 5, 0)
		local offset = direction + _vector3
		return CFrame.lookAlong(offset, lookVector)
	end,
	getMovePosition = function(createTime, speed, startPosition, direction)
		local currentTime = Workspace:GetServerTimeNow()
		local t = currentTime - createTime
		local distance = speed * t
		local _startPosition = startPosition
		local _arg0 = direction * distance
		local newVector = _startPosition + _arg0
		local lookAt
		local downOffset = Vector3.new(0, -0.3, 0)
		if t >= 2 then
			newVector = newVector + downOffset
			lookAt = direction + downOffset
		end
		return CFrame.new(newVector, lookAt)
	end,
}
return {
	default = default,
}
