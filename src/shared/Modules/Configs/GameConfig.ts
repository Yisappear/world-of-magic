import { RunService } from "@rbxts/services";

let server
if ( RunService.IsServer() === true ) {
    const data = {

        DATA_NAME: "unknown",
        DATA_TEMPLATE: {
            cash: 1000,
            
            inventory: {
                weapons: {},
                armores: {},
            },
        }

    }
    server = data
}

export default {

    server: server,

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),

    // DataService
        DATA_NAME: "unknown",
        DATA_TEMPLATE: {
            cash: 1000,
            
            inventory: {
                weapons: [],
                armores: [],
            },
        },



    // Weapons
        WEAPON_ATTRIBUTE: "WEAPON_ATTRIBUTE",
        FIRE_STAFF: "FIRE_STAFF",

    // Armore
        ARMORE_ATTRIBUTE: "ARMORE_ATTRIBUTE",

}