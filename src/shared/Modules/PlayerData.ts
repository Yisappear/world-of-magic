import { Players } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";
import GameConfig from "./Configs/GameConfig";

// constants
const PlayerStore = ProfileStore.New(GameConfig.dataName, GameConfig.dataTemplate);
const Profiles = new Map<number, ProfileStore.Profile<typeof GameConfig.dataTemplate>>();

// private functions
function loadData(player: Player) {

    // start session?
    const key = `User_` + player.UserId;
    const profile = PlayerStore.StartSessionAsync(key, {
        Cancel: (() => {
            return player.Parent !== Players;
        })
    });

    if ( profile !== undefined ) {

        profile.AddUserId(player.UserId); // GDPR
        profile.Reconcile();

        profile.OnSessionEnd.Connect(() => {
            Profiles.delete(player.UserId);
            player.Kick(`Profile session end - Please rejoin`);
        })

        if ( player.Parent === Players ) {
            Profiles.set(player.UserId, profile);
        } else {
            profile.EndSession();
        }
    } else {
        player.Kick(`Profile load fail - Please rejoin`);
    }
}

// export
export function newProfile(player: Player): ProfileStore.Profile< typeof GameConfig.dataTemplate > | undefined {
    loadData(player);
    return Profiles.get(player.UserId);
}

export function removeProfile(player: Player): void {
    const profile = Profiles.get(player.UserId);
    if ( profile !== undefined ) {
        profile.EndSession();
    }
}