-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local _Helper = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper")
local createNode = _Helper.createNode
local getCharacterDirectionVectors = _Helper.getCharacterDirectionVectors
-- private variables
local Assets = ReplicatedStorage:WaitForChild("Assets"):FindFirstChild("Weapons")
local _result = Assets
if _result ~= nil then
	_result = _result:FindFirstChild("BasicStaff")
end
local staffModel = _result
local _result_1 = Assets
if _result_1 ~= nil then
	_result_1 = _result_1:FindFirstChild("Fireball")
end
local fireball = _result_1
local _result_2 = Assets
if _result_2 ~= nil then
	_result_2 = _result_2:FindFirstChild("Meteorite")
end
local meteorite = _result_2
local _result_3 = Assets
if _result_3 ~= nil then
	_result_3 = _result_3:FindFirstChild("FireSword")
end
local fireSword = _result_3
-- export
local default = {
	staffModel = staffModel,
	projectileModel = fireball,
	damage = 20,
	speed = 4,
	firstAbilityProjectileModel = meteorite,
	firstAbilityDamage = 40,
	firstAbilitySpeed = 20,
	secondAbilityProjectileModel = fireSword,
	secondAbilityDamage = 60,
	secondAbilitySpeed = 80,
	getNodesAttack = function(self, player)
		local directions = getCharacterDirectionVectors(player)
		local _positionVector = directions.positionVector
		local _arg0 = directions.lookVector * 4
		local _exp = createNode(_positionVector + _arg0)
		local _positionVector_1 = directions.positionVector
		local _arg0_1 = directions.lookVector * 24
		local _exp_1 = createNode(_positionVector_1 + _arg0_1)
		local _positionVector_2 = directions.positionVector
		local _exp_2 = directions.lookVector * 28
		local _arg0_2 = directions.upVector * (-30)
		return { _exp, _exp_1, createNode(_positionVector_2 + (_exp_2 + _arg0_2)) }
	end,
	firstAbility = function(self, player)
		local directions = getCharacterDirectionVectors(player)
		local _positionVector = directions.positionVector
		local _exp = directions.lookVector * 4
		local _arg0 = directions.upVector * 20
		local _exp_1 = createNode(_positionVector + (_exp + _arg0))
		local _positionVector_1 = directions.positionVector
		local _exp_2 = directions.lookVector * 24
		local _arg0_1 = directions.upVector * (-40)
		local nodes = { _exp_1, createNode(_positionVector_1 + (_exp_2 + _arg0_1)) }
		local function touchEffect(otherPart)
			-- find enemy from hitbox
			return { false, nil }
		end
		return { true, nodes, touchEffect }
	end,
	secondAbility = function(self, player)
		-- todo: fire sword
		return { false, nil, nil }
	end,
}
return {
	default = default,
}
