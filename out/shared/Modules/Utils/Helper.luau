-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
-- types
-- export
local function getCharacterFromPlayer(player)
	return player.Character or (player.CharacterAdded:Wait())
end
local function getCharacterDirectionVectors(player)
	local character = getCharacterFromPlayer(player)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local hrpCFrame = humanoidRootPart.CFrame
	local hrpPosition = hrpCFrame.Position
	local lookVector = hrpCFrame.LookVector
	local upVector = hrpCFrame.UpVector
	local rightVector = hrpCFrame.RightVector
	return {
		positionVector = hrpPosition,
		lookVector = lookVector,
		upVector = upVector,
		rightVector = rightVector,
	}
end
local function createNode(pos)
	local part = Instance.new("Part")
	part.Parent = Workspace
	part.Size = Vector3.one
	part.Position = pos
	part.Transparency = 0.5
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	return part
end
local function createLeaderstatsForPlayer(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	local cash = Instance.new("NumberValue")
	cash.Name = "Cash"
	cash.Value = 0
	leaderstats.Parent = player
	cash.Parent = leaderstats
end
return {
	getCharacterFromPlayer = getCharacterFromPlayer,
	getCharacterDirectionVectors = getCharacterDirectionVectors,
	createNode = createNode,
	createLeaderstatsForPlayer = createLeaderstatsForPlayer,
}
