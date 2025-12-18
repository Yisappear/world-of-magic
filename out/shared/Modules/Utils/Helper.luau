-- Compiled with roblox-ts v3.0.0
local function getCharacterFromPlayer(player)
	return player.Character or (player.CharacterAdded:Wait())
end
return {
	getCharacterFromPlayer = getCharacterFromPlayer,
}
