import { Players, RunService, HttpService } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";
import GameConfig from "shared/Modules/Configs/GameConfig";
import Network from "shared/Modules/Network";
import { addItem } from "./Inventory";

// constants
const PlayerStore = ProfileStore.New(GameConfig.DATA_NAME, GameConfig.DATA_TEMPLATE);
const Profiles = new Map<number, ProfileStore.Profile<typeof GameConfig.DATA_TEMPLATE>>();

// private functions

// profile-store
function loadProfile(player: Player): void {
    const profile = Profiles.get(player.UserId);
    if ( profile === undefined ) {
        player.Kick(`Profile load fail - Please rejoin`);
        return;
    }

    // leaderstats
        const leaderstats = player.FindFirstChild("leaderstats") as Folder;
        const cash = leaderstats.FindFirstChild("Cash") as NumberValue;
        cash.Value = profile.Data.cash;


    const item: Item = {
        name: GameConfig.FIRE_STAFF,
        itemType: "Weapon",
        equipped: false,
    };
    const armore: Item = {
        name: GameConfig.FIRE_STAFF,
        itemType: "Armore",
        armoreType: "Hat",
        equipped: false,
    }
    task.wait(7)
    Network.GiveItemEvent.Fire(player , item)
    Network.GiveItemEvent.Fire(player , item)
    Network.GiveItemEvent.Fire(player , armore)
    Network.GiveItemEvent.Fire(player , armore)
    Network.GiveItemEvent.Fire(player , armore)
    Network.GiveItemEvent.Fire(player , armore)
    Network.GiveItemEvent.Fire(player , armore)
    Network.GiveItemEvent.Fire(player , armore)
    

}

function useLoader(player: Player) {

    // leaderstats
    const leaderstats = new Instance("Folder");
    leaderstats.Name = "leaderstats";

    const Cash = new Instance("NumberValue");
    Cash.Name = "Cash";
    Cash.Value = 0;

    leaderstats.Parent = player;
    Cash.Parent = leaderstats;


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