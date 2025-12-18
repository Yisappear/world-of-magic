-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ServerStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ServerStorage
local initialize = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Initialize").default
-- folders
local Modules = ServerStorage:FindFirstChild("Modules")
-- setup
initialize(Modules)
