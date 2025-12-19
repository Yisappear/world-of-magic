import { HttpService } from "@rbxts/services";
import getProfile from "./Player";
import Network from "shared/Modules/Network";

// private functions
function onEquip(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;

    let hasItemEquipped = false;

    const allEquippedItems = new Map<string, Item>();
    profile.Data.inventory.forEach( (item, key) => {
        if ( item.equipped === false ) return;

        allEquippedItems.set(key, item);
        if ( item.itemType === itemInInventory.itemType ) {
            if ( item.itemType === "Armore" ) {
                if ( item.armoreType === itemInInventory.armoreType ) return;
            }
        
            hasItemEquipped = true
        }
    } )

    if ( !hasItemEquipped ) return;

    itemInInventory.equipped = true;

    // remotes
    
    // notification

}

function onUnequip(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;

    itemInInventory.equipped = false;

    // remotes
    // notification

}

function onSell(player: Player, data: ItemData) {
    const profile = getProfile(player);
    if ( profile === undefined ) { player.Kick("Profile don't loaded"); return; }

    const itemInInventory = profile.Data.inventory.get(data.uuid);
    if ( itemInInventory === undefined ) return;

    if ( itemInInventory.equipped === true) onUnequip(player, data);

    profile.Data.inventory.delete(data.uuid);

    // remotes
    // notification
    // reward

}

function giveItem(player: Player, data: Item) {
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

    // remotes
    // notification
    // add ui

}


// setup
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
Network.AddItemEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;
    const data = args as Item;
    giveItem(player, data);
})
Network.DelItemEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;
    const data = args as ItemData;
    onSell(player, data);
})