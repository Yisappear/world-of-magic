import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";
import GameConfig from "../GameConfig";
import { createNode } from "shared/Modules/Utils/Helper";

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
    projectileSpeed: 5,

    getPath: (player: Player): BasePart[] => {

        const playerCharacter = getCharacterFromPlayer(player);
        const playerHumanoidRootPart = playerCharacter.FindFirstChild("HumanoidRootPart") as BasePart;
        
        const position = playerHumanoidRootPart.Position;
        const lookVector = playerHumanoidRootPart.CFrame.LookVector;
        const right = playerHumanoidRootPart.CFrame.RightVector;
        const up = playerHumanoidRootPart.CFrame.UpVector;

        const node1Position = position.add(lookVector.mul(2)).add(right.mul(2)).add(up.mul(1));
        const node2Position = node1Position.add(lookVector.mul(15));
        const node3Position = node2Position.add(lookVector.mul(5).add(up.mul(-4)));

        const node1 = createNode(node1Position) // start
        const node2 = createNode(node2Position) // direct
        const node3 = createNode(node3Position) // direct + down
        
        const nodes: BasePart[] = [
            node1,
            node2,
            node3,
        ];

        print(nodes)

        return nodes;
    },

    moveAtPath: (distanceTraveled: number, nodes: BasePart[]): [boolean, CFrame] => {

        let pDistance = 0;
        for (let i = 2; i < nodes.size() + 1; i += 1) {
            const p0 = nodes[i - 2].Position;
            const p1 = nodes[i - 1].Position;
            const newPDistance = pDistance + (p1.sub(p0)).Magnitude;

            if ( newPDistance > distanceTraveled ) {
                const alpha = math.map(distanceTraveled, pDistance, newPDistance, 0, 1);
                return [false, CFrame.lookAlong(p0.Lerp(p1, alpha), p1.sub(p0))];
            }

            pDistance = newPDistance;
        }

        const p0 = nodes[nodes.size() - 2].Position;
        const p1 = nodes[nodes.size() - 1].Position;
        return [true, CFrame.lookAlong(p1, p1.sub(p0))];
    },

    touchedEffect: (otherPart: Instance): [boolean, EnemyData | undefined] => {
        

        // explosion


        const enemyHumanoid = otherPart.FindFirstChild("Humanoid") as Humanoid;
        if ( enemyHumanoid === undefined ) return [false, undefined];

        const enemyArmore = otherPart.GetAttribute(GameConfig.ARMORE_ATTRIBUTE) as number ?? 0;

        const data: EnemyData = {
            humanoid: enemyHumanoid,
            armore: enemyArmore,
        }
        return [true, data]
    },

}