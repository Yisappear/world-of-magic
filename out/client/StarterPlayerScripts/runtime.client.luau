-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ClientConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "ClientConfig").default
local initialize = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Initialize").default
-- folders
local _result = ClientConfig.PLAYER_SCRIPTS
if _result ~= nil then
	_result = _result:FindFirstChild("Modules")
end
local Modules = _result
local Components = Modules:FindFirstChild("Components")
-- setup
initialize(Modules)
initialize(Components)
