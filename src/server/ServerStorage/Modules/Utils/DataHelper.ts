import GameConfig from "shared/Modules/Configs/GameConfig";
import Network from "shared/Modules/Network";

function setSettings(player: Player, profile: ProfileStore.Profile< typeof GameConfig.DATA_TEMPLATE >) {

}

function setProfileData(player: Player, profile: ProfileStore.Profile< typeof GameConfig.DATA_TEMPLATE >) {
    if ( profile === undefined ) return;

    // leaderstats
    const leaderstats = player.FindFirstChild("leaderstats") as Folder;
    const Cash = leaderstats.FindFirstChild("Cash") as NumberValue;
    Cash.Value = profile.Data.cash;

    // inventory ui
    profile.Data.inventory.forEach( (item, key) => {
        item.equipped = false;
        Network.GiveItemEvent.Fire(player, item);
    } )
}

function createSetup(player: Player) {

    // leaderstats
    const leaderstats = new Instance("Folder");
    leaderstats.Name = "leaderstats";

    const Cash = new Instance("NumberValue");
    Cash.Name = "Cash";
    Cash.Value = 0;

    leaderstats.Parent = player;
    Cash.Parent = leaderstats;

}

function setDataDEBUG(player: Player) {

    // add item
    const weapon: Item = {
        name: "FireStaff",
        itemType: "Weapon",
        equipped: false,
    }
    const armore: Item = {
        name: "FireStaff",
        itemType: "Armore",
        armoreType: "Hat",
        equipped: false,
    }
    Network.GiveItemEvent.Fire(player, weapon)
    Network.GiveItemEvent.Fire(player, weapon)
    Network.GiveItemEvent.Fire(player, armore)
    Network.GiveItemEvent.Fire(player, armore)
    Network.GiveItemEvent.Fire(player, armore)

}

// setup
export function loadData(player: Player, profile: ProfileStore.Profile< typeof GameConfig.DATA_TEMPLATE >) {
    if ( profile === undefined ) return;

    createSetup(player);
    setProfileData(player, profile);
    setSettings(player, profile);

    setDataDEBUG(player);
}