-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
-- folder 
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local _result = Modules
if _result ~= nil then
	_result = _result:FindFirstChild("Projectiles")
end
local Projectiles = _result
local function onRender(name, startPosition, endPosition)
	local projectile = require(Projectiles:FindFirstChild(name))
end
return nil
