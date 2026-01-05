import { Players } from "@rbxts/services";
import ProfileStore from "@rbxts/profile-store";
import GameConfig from "./Configs/GameConfig";
import { createLeaderstatsForPlayer } from "./Utils/Helper";

// module logic constants
const PlayerStore = ProfileStore.New(GameConfig.dataName, GameConfig.dataTemplate);
const Profiles = new Map<number, ProfileStore.Profile<typeof GameConfig.dataTemplate>>();

// private functions
function dataOnChange(player: Player): void {
    const profile = Profiles.get(player.UserId);
    if ( !profile ) {
        player.Kick("Profile don't finded, please rejoin.");
        return;
    }
    // constants
    const leaderstats = player.FindFirstChild("leaderstats") as Folder;
    const cash = leaderstats.FindFirstChild("Cash") as NumberValue;

    // setup data
    cash.Value = profile.Data.cash;

    // remote for change data


}

function createData(player: Player): void {

    createLeaderstatsForPlayer(player);
    dataOnChange(player);

}

function loadData(player: Player) {
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

    createData(player);
}

// export
export function getNewProfile(player: Player): typeof GameConfig.dataTemplate | undefined {
    loadData(player);
    return Profiles.get(player.UserId)?.Data;
}

export function getProfile(player: Player): typeof GameConfig.dataTemplate | undefined {
    return Profiles.get(player.UserId)?.Data;
}

export function removeProfile(player: Player): void {
    const profile = Profiles.get(player.UserId);
    if ( profile !== undefined ) {
        profile.EndSession();
    }
}