import { ReplicatedStorage } from "@rbxts/services";

// folder 
const Modules = ReplicatedStorage.FindFirstChild("Modules") as Folder;
const Projectiles = Modules?.FindFirstChild("Projectiles") as Folder;

function onRender(name: string, startPosition: Vector3, endPosition: Vector3) {

    const projectile = require(Projectiles.FindFirstChild(name) as ModuleScript) as Projectile;

}


