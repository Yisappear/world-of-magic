-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProfileStore = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "profile-store", "src")
-- constants
local DATA_NAME = "unknown"
local DATA_TEMPLATE = {
	cash = 333,
	max_items = 7,
	inventory = {
		equipped = {},
		unequipped = {},
	},
	settings = {},
}
local PlayerStore = ProfileStore.New(DATA_NAME, DATA_TEMPLATE)
local Profiles = {}
-- private functions
local function loadData(player)
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
end
local function onPlayerAdded(player)
	loadData(player)
end
-- export
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
