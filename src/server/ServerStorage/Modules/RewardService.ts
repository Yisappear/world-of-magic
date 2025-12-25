import { notifyKillReward } from "./Notification";
import getProfile from "./Player";

export function rewardForKill(player: Player, amount: number, enemyName: string) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const leaderstats = player.FindFirstChild("leaderstats") as Folder;
    const cash = leaderstats?.FindFirstChild("Cash") as NumberValue;

    const newValue = profile.Data.cash + amount;
    profile.Data.cash = newValue;
    cash.Value = profile.Data.cash;

    notifyKillReward(player, amount, enemyName);
}

