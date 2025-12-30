import { RunService } from "@rbxts/services";

export default {

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),

    
}