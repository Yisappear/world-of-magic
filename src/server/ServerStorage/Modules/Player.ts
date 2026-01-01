import { Players } from "@rbxts/services";
import GameConfig from "shared/Modules/Configs/GameConfig";
import { newProfile, removeProfile } from "shared/Modules/PlayerData";
import { createLeaderstatsForPlayer } from "shared/Modules/Utils/Helper";

// types
interface PlayerStruct {
    player: Player,
    data: ProfileStore.Profile<typeof GameConfig.dataTemplate>,
    
}

// main array
const players: PlayerStruct[] = [];

// private functions
function newPlayer(player: Player) {
    const data = newProfile(player);
    if ( data === undefined ) {
        player.Kick("Profile error, please rejoin.");
        return;
    }

    createLeaderstatsForPlayer(player);

    players.push({
        player: player,
        data: data,
    })
}

function removePlayer(player: Player) {
    removeProfile(player);

    const idx = players.findIndex(v => v.player === player);
    players.remove(idx);
}

// export
export function getPlayerStruct(player: Player) {
    for (const i of players) {
        if ( i.player === player ) {
            return i;
        }
    }

    player.Kick("PlayerStruct don't exist.");
    return;
}

// setup
Players.PlayerAdded.Connect(newPlayer);
Players.PlayerRemoving.Connect(removePlayer);