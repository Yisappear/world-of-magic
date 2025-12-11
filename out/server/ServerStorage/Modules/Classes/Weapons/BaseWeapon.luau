-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- server class
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local RunService = _services.RunService
local Workspace = _services.Workspace
local WeaponClass = TS.import(script, game:GetService("ServerStorage"), "Modules", "Classes", "Weapon").default
local BaseWeaponConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "Weapons", "BaseWeaponConfig").default
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local BaseWeapon
do
	local super = WeaponClass
	BaseWeapon = setmetatable({}, {
		__tostring = function()
			return "BaseWeapon"
		end,
		__index = super,
	})
	BaseWeapon.__index = BaseWeapon
	function BaseWeapon.new(...)
		local self = setmetatable({}, BaseWeapon)
		return self:constructor(...) or self
	end
	function BaseWeapon:constructor(...)
		super.constructor(self, ...)
	end
	function BaseWeapon:getRender()
		local bulletModel = GameConfig.ObjectPoolBullets:FindFirstChild(self.bullet.Name)
		if bulletModel ~= nil then
			return bulletModel
		end
		local bullet = self.bullet:Clone()
		bullet.CanCollide = false
		bullet.Anchored = true
		return bullet
	end
	function BaseWeapon:getEndPosition(player)
		local ray = GameConfig.getCameraRay:InvokeClient(player)
		if ray == nil then
			return nil
		end
		local _direction = ray.Direction
		local _range = self.range
		local direction = _direction * _range
		local endPosition = ray.Origin + direction
		print(endPosition)
		return endPosition
	end
	function BaseWeapon:getSetup(player)
		local endPosition = self:getEndPosition(player)
		if endPosition == nil then
			return nil
		end
		local playerCharacter = player.Character or (select(2, player.CharacterAdded:Wait()))
		local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart == nil then
			return nil
		end
		local setup = {
			endPosition = endPosition,
			playerCharacter = playerCharacter,
			humanoidRootPart = humanoidRootPart,
		}
		return setup
	end
	function BaseWeapon:getStartCframe(cf)
		local lookVector = cf.LookVector
		local startPosition = CFrame.lookAlong(cf.Position, lookVector)
		return startPosition
	end
	function BaseWeapon:runMovement(bullet, bulletPostion, distance, move, endPosition)
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += move
				else
					_shouldIncrement = true
				end
				if not (i <= distance) then
					break
				end
				if bullet.Parent ~= Workspace then
					break
				end
				local alpha = i / distance
				local newPostion = bulletPostion:Lerp(endPosition, alpha)
				bullet.Position = newPostion
				RunService.Heartbeat:Wait()
			end
		end
	end
	function BaseWeapon:attack(player)
		if RunService:IsServer() == false then
			return { player, nil }
		end
		local victim
		local fireball = self:getRender()
		local playerSetup = self:getSetup(player)
		if playerSetup == nil then
			return { player, nil }
		end
		local startPosition = self:getStartCframe(playerSetup.humanoidRootPart.CFrame)
		local _position = startPosition.Position
		local _endPosition = playerSetup.endPosition
		local distance = math.max(0, ((_position - _endPosition).Magnitude + 1))
		local move = (self.bulletSpeed / 144)
		-- start loop
		victim = nil
		fireball:PivotTo(startPosition)
		fireball.Parent = Workspace
		-- property don't work how i would like
		fireball.Touched:Connect(function(otherPart)
			local character = otherPart.Parent
			local humanoid = character:FindFirstChild("Humanoid")
			local plr = Players:GetPlayerFromCharacter(otherPart.Parent)
			if humanoid == nil or plr == player then
				return nil
			end
			fireball.Parent = GameConfig.ObjectPoolBullets
			victim = character
		end)
		self:runMovement(fireball, fireball.Position, distance, move, playerSetup.endPosition)
		if fireball.Parent == Workspace then
			fireball.Parent = GameConfig.ObjectPoolBullets
		end
		return { player, victim }
	end
end
local default = {
	weapon = BaseWeapon.new(BaseWeaponConfig.model, BaseWeaponConfig.bullet, BaseWeaponConfig.bulletSpeed, BaseWeaponConfig.damage, BaseWeaponConfig.cooldown, BaseWeaponConfig.range),
}
return {
	default = default,
}
