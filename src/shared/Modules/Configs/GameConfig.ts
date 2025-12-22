import { RunService } from "@rbxts/services";

export default {

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),

    // DataService
        DATA_NAME: "unknown",
        DATA_TEMPLATE: {
            cash: 333,
            inventory: new Map<string, Item>(),
            settings: new Map<string, string | number | boolean>(),
        },

    // Weapons
        COOLDOWN: "COOLDOWN",
        LAST_WEAPON: "LAST_WEAPON",

        WEAPON_ATTRIBUTE: "WEAPON_ATTRIBUTE",
        FIRE_STAFF: "FireStaff",

    // Armore
        ARMORE_ATTRIBUTE: "ARMORE_ATTRIBUTE",

}