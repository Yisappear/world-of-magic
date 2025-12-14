export function getCharacterFromPlayer(player: Player) {
    return player.Character ?? player.CharacterAdded.Wait()[0]
}