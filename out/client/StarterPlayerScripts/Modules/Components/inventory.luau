-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local ReactRoblox = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react-roblox")
local MainFrame = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory").default
local LOCAL_PLAYER = Players.LocalPlayer
local playerGui = LOCAL_PLAYER:FindFirstChild("PlayerGui")
local mainFrameUi = React.createElement(MainFrame, {})
local root = ReactRoblox.createRoot(playerGui)
root:render(mainFrameUi)
return nil
