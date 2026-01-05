-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProfileStore = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "profile-store", "src")
local GameConfig = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Configs", "GameConfig").default
local createLeaderstatsForPlayer = TS.import(script, game:GetService("ReplicatedStorage"), "Modules", "Utils", "Helper").createLeaderstatsForPlayer
-- module logic constants
local PlayerStore = ProfileStore.New(GameConfig.dataName, GameConfig.dataTemplate)
local Profiles = {}
-- private functions
local function dataChange(player)
	local _userId = player.UserId
	local profile = Profiles[_userId]
	if not profile then
		player:Kick("Profile don't finded, please rejoin.")
		return nil
	end
	-- constants
	local leaderstats = player:FindFirstChild("leaderstats")
	local cash = leaderstats:FindFirstChild("Cash")
	-- setup data
	cash.Value = profile.Data.cash
	-- remote for change data
end
local function createData(player)
	createLeaderstatsForPlayer(player)
	dataChange(player)
end
local function loadData(player)
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
	createData(player)
end
-- export
local function getNewProfile(player)
	loadData(player)
	local _userId = player.UserId
	local _result = Profiles[_userId]
	if _result ~= nil then
		_result = _result.Data
	end
	return _result
end
local function getProfile(player)
	local _userId = player.UserId
	local _result = Profiles[_userId]
	if _result ~= nil then
		_result = _result.Data
	end
	return _result
end
local function removeProfile(player)
	local _userId = player.UserId
	local profile = Profiles[_userId]
	if profile ~= nil then
		profile:EndSession()
	end
end
return {
	getNewProfile = getNewProfile,
	getProfile = getProfile,
	removeProfile = removeProfile,
}
