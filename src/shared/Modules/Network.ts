import { ReplicatedStorage, RunService } from "@rbxts/services";

// folders
const Events = ReplicatedStorage.WaitForChild("Events") as Folder;
const WeaponEvents = ReplicatedStorage.FindFirstChild("WeaponEvents") as Folder;
const ProjectileEvents = ReplicatedStorage.FindFirstChild("ProjectilesEvents") as Folder;


let server
if ( RunService.IsServer() ) {
    const data = {

    }
    server = data;
}

export default {

    server: server,


    // RemoteEvents

        // Weapon
        AttackEvent: WeaponEvents.FindFirstChild("Attack") as RemoteEvent,

        // Projectile
        RenderEvent: ProjectileEvents.FindFirstChild("Render") as RemoteEvent,

    // RemoteFunctions

    // BindableEvents (client)

    // BindableFunctions (client)

}