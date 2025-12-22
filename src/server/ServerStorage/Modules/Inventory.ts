import { HttpService } from "@rbxts/services";
import getProfile from "./Player";
import Network from "shared/Modules/Network";
import GameConfig from "shared/Modules/Configs/GameConfig";

// private functions
function onEquip(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;
        
    const countEquippedItems: Item[] = []
    profile.Data.inventory.forEach( (item, key) => { if ( item.equipped === true ) countEquippedItems.push(item); } );
    if ( (countEquippedItems.size() - 1) === 4 ) return; // 1 weapon and 3 armore

    let hasWeapon = false;
    let hasArmore = false;
    for (const item of countEquippedItems) {
        if ( item.itemType === "Weapon" ) hasWeapon = true;
        if ( item.itemType === "Armore" ) {
            if ( item.armoreType === itemInInventory.armoreType ) hasArmore = true;
        }
    }

    if ( hasArmore === false && hasWeapon === false ) {
        itemInInventory.equipped = true;

        if ( itemInInventory.itemType === "Armore" ) {
            Network.EquipItemEvent.FireClient(player, data);
            Network.DelItemEvent.FireClient(player, data);
        }
        if ( itemInInventory.itemType === "Weapon" ) {
            Network.EquipWeaponEvent.FireClient(player);
            Network.EquipItemEvent.FireClient(player, data);
            Network.DelItemEvent.FireClient(player, data);
            player.SetAttribute(GameConfig.WEAPON_ATTRIBUTE, itemInInventory.name);
        }
    }
}

function onUnequip(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;

    itemInInventory.equipped = false;

    // remotes
    player.SetAttribute(GameConfig.WEAPON_ATTRIBUTE, "");
    Network.UnequipItemEvent.FireClient(player, data);
    Network.AddItemEvent.FireClient(player, data);
    if ( itemInInventory.itemType === "Weapon" ) Network.UnequipWeaponEvent.FireClient(player);

    // notification

}

function onSell(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;

    if ( itemInInventory.equipped === true) {
        
        itemInInventory.equipped = false;
        profile.Data.inventory.delete(data.uuid);
        Network.UnequipItemEvent.FireClient(player, data);

        return;
    }

    itemInInventory.equipped = false;
    profile.Data.inventory.delete(data.uuid);

    // remotes
    Network.DelItemEvent.FireClient(player, data);
    // notification
    // reward

}

function isEquipped(player: Player, uuid: string): boolean {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return false; }

    const itemInInventory = profile.Data.inventory.get(uuid);
    if ( itemInInventory === undefined ) return false;

    return itemInInventory.equipped;
}

// export
export function addItem(player: Player, data: Item) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }
    
    if ( data === undefined ) return;
    
    const uuid = HttpService.GenerateGUID(false);

    profile.Data.inventory.set(uuid, {
        name: data.name,
        itemType: data.itemType,
        equipped: false,
    })

    if ( data.itemType === "Armore" ) {
        profile.Data.inventory.set(uuid, {
        name: data.name,
        itemType: data.itemType,
        armoreType: data.armoreType,
        equipped: false,
    })
    }

    const sendData: ItemData = {
        uuid: uuid,
        name: data.name,
        itemType: data.itemType,
    }

    // remotes
    Network.AddItemEvent.FireClient(player, sendData);
    // notification
    // add ui

}

// setup
// remote event
Network.EquipItemEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;
    const data = args as ItemData;
    onEquip(player, data);
})
Network.UnequipItemEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;
    const data = args as ItemData;
    onUnequip(player, data);
})
Network.DelItemEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;
    const data = args as ItemData;
    onSell(player, data);
})
// remote function
Network.IsEquipped.OnServerInvoke = (player, args) => {
    if ( args === undefined ) return;
    const uuid = args as string;
    return isEquipped(player, uuid);
}
// bindable event
Network.GiveItemEvent.Event.Connect((player, args: Item) => {
    if ( args === undefined ) return;
    const data = args as Item;
    addItem(player, data);
})