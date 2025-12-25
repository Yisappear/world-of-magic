-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
local function getCharacterFromPlayer(player)
	if player == nil then
		error("why u call this function without player parametr")
	end
	return player.Character or (player.CharacterAdded:Wait())
end
local function createNode(pos)
	local node = Instance.new("Part")
	node.Parent = Workspace
	node.Size = Vector3.new(1, 1, 1)
	node.Position = pos
	node.Transparency = 0.5
	node.CanCollide = false
	node.CanTouch = false
	node.Anchored = true
	return node
end
return {
	getCharacterFromPlayer = getCharacterFromPlayer,
	createNode = createNode,
}
