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
    cooldown: 1.5,
    animation: "",
    icon: "",

    projectileModel: fireball,
    projectileSpeed: 40,

    getStartPosition: (player: Player): [Vector3, Vector3] => {
        const playerCharacter = getCharacterFromPlayer(player);
        const playerHumanoidRootPart = playerCharacter.FindFirstChild("HumanoidRootPart") as BasePart;

        const lookVector = playerHumanoidRootPart.CFrame.Rotation;
        const position = playerHumanoidRootPart.Position;

        const direction = lookVector.LookVector;
        const right = playerHumanoidRootPart.CFrame.RightVector;
        const up = playerHumanoidRootPart.CFrame.UpVector;

        const offset = 
            position
                .add(direction.mul(2))
                .add(right.mul(2))
                .add(up.mul(1))

        return [offset, direction];
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
        let lookAt = direction;
        let up = new Vector3(0, 1, 0)

        if ( t > 5 ) {
            const downOffset = new Vector3(0, -1, 0);
            lookAt = direction.mul(downOffset);
        }

        return CFrame.lookAlong(newVector, lookAt, up);
    },

}