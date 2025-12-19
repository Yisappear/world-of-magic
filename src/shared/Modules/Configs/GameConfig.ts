import { RunService } from "@rbxts/services";

export default {

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),

    // DataService
        DATA_NAME: "unknown",
        DATA_TEMPLATE: {
            cash: 1000,

            inventory: new Map<string, Item>(),
        },



    // Weapons
        WEAPON_ATTRIBUTE: "WEAPON_ATTRIBUTE",
        FIRE_STAFF: "FireStaff",

        CAN_HIT: "CAN_HIT",
        COOLDOWN: "COOLDOWN",
        LAST_WEAPON: "LAST_WEAPON",

    // Armore
        ARMORE_ATTRIBUTE: "ARMORE_ATTRIBUTE",

}