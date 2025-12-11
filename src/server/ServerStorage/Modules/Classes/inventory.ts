import gameConfig from "shared/Modules/Configs/GameConfig";
import getProfile from "../Player";
import { HttpService } from "@rbxts/services";

export class Inventory {

    constructor( player: Player ) {
            
    }

    public onStart( player: Player ) {
        

        // networking | notification

        






    } // remote init
    
    public createItem( player: Player, weaponType: string | number ) {
        const profile = getProfile(player);
        if ( profile === undefined ) {
            player.Kick(`Profile session end - Please rejoin`);
            return;
        }

        const uuid = HttpService.GenerateGUID(false) as string;

        const itemValue: Item = {
            equipped: false,
            uuid: uuid, 

            // weapon type weapon / armore
            // weapon name for find config
        }

        profile.Data.inventory.weapons.set( uuid, itemValue )

        // notification / or fire ( update UI in client )

    }
    
    private deleteItem( player: Player, uuid: string ) {
        const profile = getProfile(player);
        if ( profile === undefined ) {
            player.Kick(`Profile session end - Please rejoin`);
            return;
        }

        profile.Data.inventory.weapons.delete( uuid )

    }

    private getEquippedItems(player: Player) {
        const profile = getProfile(player);
        if ( profile === undefined ) {
            player.Kick(`Profile session end - Please rejoin`);
            return;
        }

        const allItems: { uuid: string, equipped: boolean }[] = [];
        const inventory = profile.Data.inventory.weapons // delete :P

        // forEach + push / or forEach + props.equipped === true + push

        const equippedItems: { uuid: string }[] = []; 
        // for + push

        return equippedItems;
    }

    private equipItem( player: Player, uuid: string ) {
        const profile = getProfile(player);
        if ( profile === undefined ) {
            player.Kick(`Profile session end - Please rejoin`);
            return;
        }

        const item = profile.Data.inventory.weapons.get( uuid );
        if ( item === undefined ) return;

        item.equipped = true;

        // notification, or fire remote update UI
        // WARN! player could have only ONE weapon
    }

    private unequipItem( player: Player, uuid: string ) {
        const profile = getProfile(player);
        if ( profile === undefined ) {
            player.Kick(`Profile session end - Please rejoin`);
            return;
        }

        const item = profile.Data.inventory.weapons.get( uuid );
        if ( item === undefined ) return;

        item.equipped = false;

        // notification / or fire update UI in client
    }

}