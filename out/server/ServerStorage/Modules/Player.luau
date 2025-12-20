-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProfileStore = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "profile-store", "src")
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local Network = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Network").default
-- constants
local PlayerStore = ProfileStore.New(GameConfig.DATA_NAME, GameConfig.DATA_TEMPLATE)
local Profiles = {}
-- private functions
-- profile-store
local function loadProfile(player)
	local _userId = player.UserId
	local profile = Profiles[_userId]
	if profile == nil then
		player:Kick(`Profile load fail - Please rejoin`)
		return nil
	end
	-- leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	local cash = leaderstats:FindFirstChild("Cash")
	cash.Value = profile.Data.cash
	local item = {
		name = GameConfig.FIRE_STAFF,
		itemType = "Weapon",
		equipped = false,
	}
	local armore = {
		name = GameConfig.FIRE_STAFF,
		itemType = "Armore",
		armoreType = "Hat",
		equipped = false,
	}
	task.wait(7)
	Network.GiveItemEvent:Fire(player, item)
	Network.GiveItemEvent:Fire(player, item)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
	Network.GiveItemEvent:Fire(player, armore)
end
local function useLoader(player)
	-- leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	local Cash = Instance.new("NumberValue")
	Cash.Name = "Cash"
	Cash.Value = 0
	leaderstats.Parent = player
	Cash.Parent = leaderstats
	task.wait(1)
	loadProfile(player)
end
local function onPlayerAdded(player)
	-- start session?
	local key = `User_` .. tostring(player.UserId)
	local profile = PlayerStore:StartSessionAsync(key, {
		Cancel = (function()
			return player.Parent ~= Players
		end),
	})
	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()
		profile.OnSessionEnd:Connect(function()
			local _userId = player.UserId
			Profiles[_userId] = nil
			player:Kick(`Profile session end - Please rejoin`)
		end)
		if player.Parent == Players then
			local _userId = player.UserId
			Profiles[_userId] = profile
		else
			profile:EndSession()
		end
	else
		player:Kick(`Profile load fail - Please rejoin`)
	end
	useLoader(player)
end
-- export functions
local function getProfile(player)
	local _userId = player.UserId
	return Profiles[_userId]
end
-- setup
Players.PlayerAdded:Connect(function(player)
	return onPlayerAdded(player)
end)
Players.PlayerRemoving:Connect(function(player, reason)
	local _userId = player.UserId
	local profile = Profiles[_userId]
	if profile ~= nil then
		profile:EndSession()
	end
end)
return {
	default = getProfile,
}
