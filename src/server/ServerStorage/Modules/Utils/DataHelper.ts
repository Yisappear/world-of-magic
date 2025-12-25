import GameConfig from "shared/Modules/Configs/GameConfig";
import Network from "shared/Modules/Network";

type profile = ProfileStore.Profile< typeof GameConfig.DATA_TEMPLATE >


function setSettings(player: Player, profile: profile) {

}

function setData(player: Player, profile: profile) {
    if ( profile === undefined ) return;

    // leaderstats
    const leaderstats = player.FindFirstChild("leaderstats") as Folder;
    const Cash = leaderstats.FindFirstChild("Cash") as NumberValue;
    Cash.Value = profile.Data.cash;

    // inventory ui
    Network.LoadInventoryEvent.Fire(player)
}

function create(player: Player) {

    // leaderstats
    const leaderstats = new Instance("Folder");
    leaderstats.Name = "leaderstats";

    const Cash = new Instance("NumberValue");
    Cash.Name = "Cash";
    Cash.Value = 0;

    leaderstats.Parent = player;
    Cash.Parent = leaderstats;

}

function DEBUG(player: Player) {

    const weapon: Item = {
        name: "FireStaff",
        itemType: "Weapon",
        equipped: false,
    };
    const armore: Item = {
        name: "FireStaff",
        itemType: "Armore",
        armoreType: "Hat",
        equipped: false,
    };
    Network.GiveItemToPlayerEvent.Fire(player, weapon);
    Network.GiveItemToPlayerEvent.Fire(player, weapon);
    Network.GiveItemToPlayerEvent.Fire(player, armore);

}

// setup
export function loadData(player: Player, profile: profile) {
    if ( profile === undefined ) return;

    create(player);
    setData(player, profile);
    setSettings(player, profile);

    DEBUG(player);
}