-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local RunService = _services.RunService
-- types
-- folders
local Events = ReplicatedStorage:WaitForChild("Events")
local WeaponEvents = Events:FindFirstChild("WeaponEvents")
-- private functions
local function getEvent(eventName, folder, eventType)
	local hasEvent = folder:FindFirstChild(eventName)
	if hasEvent ~= nil then
		return hasEvent
	end
	if RunService:IsServer() then
		local event = Instance.new(eventType)
		event.Name = eventName
		event.Parent = folder
		return event
	end
	local eventForClient = folder:WaitForChild(eventName)
	return eventForClient
end
local default = {
	Attack = getEvent("Attack", WeaponEvents, "RemoteEvent"),
	Ability = getEvent("Ability", WeaponEvents, "RemoteEvent"),
}
return {
	default = default,
}
