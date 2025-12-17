import { Players, RunService } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";

// constants
const PlayerStore = ProfileStore.New("unknown", {});
const Profiles = new Map<number, ProfileStore.Profile<{}>>();

// private functions

// profile-store
function loadProfile(player: Player): void {
    const profile = Profiles.get(player.UserId);
    if ( profile === undefined ) {
        player.Kick(`Profile load fail - Please rejoin`);
        return;
    }

}

function useLoader(player: Player) {

    task.wait(1); // for init all 

    loadProfile(player);
}

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

    useLoader(player);
}

// export functions
export default function getProfile(player: Player): ProfileStore.Profile< {} > | undefined {
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