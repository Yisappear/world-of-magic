-- Compiled with roblox-ts v3.0.0
local function notifyKillReward(player, amount, enemyName)
	local sendData = {}
	local notifyMSG = `reward: {amount} cash, for destroy: {enemyName}`
	-- remote
end
local function notifyAddItem(player, itemName)
	local sendData = {}
	local notifyMSG = `new item: {itemName}`
	-- remote
end
local function notifyDelItem(player, itemName)
	local sendData = {}
	local notifyMSG = `delete item: {itemName}`
	-- remote
end
local function notifySellItem(player, itemName)
end
local function notifyEquipppedState(player, state)
end
local function notifyHitEnemy(player)
	-- sound for player and ui at center
end
return {
	notifyKillReward = notifyKillReward,
	notifyAddItem = notifyAddItem,
	notifyDelItem = notifyDelItem,
	notifySellItem = notifySellItem,
	notifyEquipppedState = notifyEquipppedState,
	notifyHitEnemy = notifyHitEnemy,
}
