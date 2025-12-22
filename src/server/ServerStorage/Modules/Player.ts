import { Players } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";
import GameConfig from "shared/Modules/Configs/GameConfig";
import { loadData } from "./Utils/DataHelper";

// constants
const PlayerStore = ProfileStore.New(GameConfig.DATA_NAME, GameConfig.DATA_TEMPLATE);
const Profiles = new Map<number, ProfileStore.Profile<typeof GameConfig.DATA_TEMPLATE>>();

// private functions
function onPlayerAdded(player: Player): void {
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

    loadData(player, profile);

    // DEBUG
    // profile.Data.inventory = new Map();
}

// export
export default function getProfile(player: Player): ProfileStore.Profile< typeof GameConfig.DATA_TEMPLATE > | undefined {
    return Profiles.get(player.UserId);
}

// setup
Players.PlayerAdded.Connect((player: Player): void => onPlayerAdded(player))
Players.PlayerRemoving.Connect((player: Player, reason: Enum.PlayerExitReason): void => {
    const profile = Profiles.get(player.UserId);
    if ( profile !== undefined ) {
        profile.EndSession();
    }
})