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
local projectileModel = _result_1
-- export
local default = {
	staffModel = staffModel,
	projectileModel = projectileModel,
	damage = 20,
	speed = 4,
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
	getNodesAbilityZ = function(self, player) end,
}
return {
	default = default,
}
