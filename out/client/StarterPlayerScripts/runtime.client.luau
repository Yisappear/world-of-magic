-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local initialize = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Initialize").default
-- folders
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local Controllers = Modules:FindFirstChild("Controllers")
-- setup
initialize(Controllers)
