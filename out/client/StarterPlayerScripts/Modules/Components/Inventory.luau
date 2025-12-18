-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ClientConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "ClientConfig").default
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
local ReactRoblox = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react-roblox")
local InventoryComponent = TS.import(script, game:GetService("ReplicatedStorage"), "Ui", "Inventory").default
local inventory = React.createElement(InventoryComponent, {})
local root = ReactRoblox.createRoot(ClientConfig.PLAYER_GUI)
root:render(inventory)
return nil
