import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";

// folders
const Assets = ReplicatedStorage.WaitForChild("Assets") as Folder;
const WeaponAssets = Assets.FindFirstChild("WeaponAssets") as Folder;

// constants
const fireStaff = WeaponAssets.FindFirstChild("FireStaff") as BasePart;
const fireball = WeaponAssets.FindFirstChild("Fireball") as BasePart;

export default {

    model: fireStaff,
    damage: 20,
    animation: "",

    projectileModel: fireball,
    projectileSpeed: 40,

    getStartPosition: (player: Player): CFrame => {
        const playerCharacter = getCharacterFromPlayer(player);
        const playerHumanoidRootPart = playerCharacter.FindFirstChild("HumanoidRootPart") as BasePart;

        const lookVector = playerHumanoidRootPart.CFrame.LookVector;
        const position = playerHumanoidRootPart.CFrame.Position;

        const direction = position.sub(lookVector);
        const offset = direction.add(new Vector3(3, 5, 0));

        return CFrame.lookAlong(offset, lookVector);
    },

    getMovePosition: (
        createTime: number,
        speed: number,
        startPosition: Vector3,
        direction: Vector3
    ): CFrame => {

        const currentTime = Workspace.GetServerTimeNow();
        const t = currentTime - createTime;
        const distance = speed * t;
        
        let newVector = startPosition.add(direction.mul(distance));
        let lookAt!: Vector3;

        const downOffset = new Vector3(0, -0.3, 0);
        if ( t >= 2 ) {
            newVector = newVector.add(downOffset);
            lookAt = direction.add(downOffset);
        }

        return new CFrame(newVector, lookAt);
    },

}