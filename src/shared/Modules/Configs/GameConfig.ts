import { RunService } from "@rbxts/services";

export default {

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),

    // data
    dataName: "unknown",
    dataTemplate: {
        cash: 333,
        max_items: 7,
        inventory: {
            equipped: [],
            unequipped: [],
        },
        settings: new Map(),
    },


    
}