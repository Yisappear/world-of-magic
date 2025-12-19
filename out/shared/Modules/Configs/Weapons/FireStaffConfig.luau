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
		local position = playerHumanoidRootPart.Position
		local direction = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local right = playerHumanoidRootPart.CFrame.RightVector
		local up = playerHumanoidRootPart.CFrame.UpVector
		print(up)
		local _arg0 = direction * 2
		local _exp = position + _arg0
		local _arg0_1 = right * 2
		local _arg0_2 = up * 1
		local offset = _exp + _arg0_1 + _arg0_2
		return CFrame.lookAlong(offset, direction)
	end,
	getMovePosition = function(createTime, speed, startPosition, direction)
		local currentTime = Workspace:GetServerTimeNow()
		local t = currentTime - createTime
		local distance = speed * t
		local _startPosition = startPosition
		local _arg0 = direction * distance
		local newVector = _startPosition + _arg0
		local lookAt = direction
		local up = Vector3.new(0, 1, 0)
		if t > 5 then
			local downOffset = Vector3.new(0, -1, 0)
			lookAt = direction * downOffset
		end
		return CFrame.lookAlong(newVector, lookAt, up)
	end,
}
return {
	default = default,
}
