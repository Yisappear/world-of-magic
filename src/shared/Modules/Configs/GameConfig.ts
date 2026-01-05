import { RunService } from "@rbxts/services";

export default {

    isServer: RunService.IsServer(),
    isClient: RunService.IsClient(),
    isStudio: RunService.IsStudio(),

    // data
    dataName: "unknown",
    dataTemplate: {
        cash: 333,
        max_items: 7,
        inventory: {
            equipped: [
                { uuid: ":P", itemType: ":P", itemName: ":P", equipped: false }
            ],
            unequipped: [
                { uuid: "", itemType: "", itemName: "", equipped: false }
            ],
        },
    },


    
}