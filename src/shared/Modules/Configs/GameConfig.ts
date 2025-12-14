import { RunService } from "@rbxts/services";

let server
if ( RunService.IsServer() === true ) {
    const data = {

        DATA_NAME: "unknown",
        DATA_TEMPLATE: {
            cash: 1000
        }

    }
    server = data
}

export default {

    server: server,

    isServer: RunService.IsServer(),
    isStudio: RunService.IsStudio(),
    isClient: RunService.IsClient(),






}