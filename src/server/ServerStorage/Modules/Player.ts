import { Players } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";

// constants
const DATA_NAME =  "unknown";
const DATA_TEMPLATE =  {
    cash: 333,
    max_items: 7,
    inventory: {
        equipped: [],
        unequipped: [],
    },
    settings: new Map(),
};
const PlayerStore = ProfileStore.New(DATA_NAME, DATA_TEMPLATE);
const Profiles = new Map<number, ProfileStore.Profile<typeof DATA_TEMPLATE>>();

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

function onPlayerAdded(player: Player): void {
    
    loadData(player);
}

// export
export default function getProfile(player: Player): ProfileStore.Profile< typeof DATA_TEMPLATE > | undefined {
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