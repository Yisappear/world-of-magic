import Network from "shared/Modules/Network";
import getProfile from "./Player";
import GameConfig from "shared/Modules/Configs/GameConfig";

// private functions
function renderArmore(player: Player) {} 

function onUnequip(player: Player): void {
    const profile = getProfile(player);
    if ( profile === undefined ) {
        player.Kick("rejoin please, you're profile dont loaded");
        return;
    }
    
    const armoreInventory = profile.Data.inventory;
    
    player.SetAttribute(GameConfig.ARMORE_ATTRIBUTE, 0);
}

function onEquip(player: Player): void {
    const profile = getProfile(player);
    if ( profile === undefined ) {
        player.Kick("rejoin please, you're profile dont loaded");
        return;
    }

    let equipped!: string

    const armoreInventory = profile.Data.inventory;
    

    // render armore on character

}



Network.EquipArmoreEvent.OnServerEvent.Connect(() => {

});