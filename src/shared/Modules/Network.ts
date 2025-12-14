import { ReplicatedStorage, RunService } from "@rbxts/services";

// folders
const Events = ReplicatedStorage.WaitForChild("Events");


let server
if ( RunService.IsServer() ) {
    const data = {

    }
    server = data;
}

export default {

    server: server,


    // RemoteEvents

    // RemoteFunctions

    // BindableEvents (client)

    // BindableFunctions (client)

}