import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";
import GameConfig from "shared/Modules/Configs/GameConfig";
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
    projectileSpeed: 21,

    rewardMult: 1,

    getPathAttack: (player: Player): BasePart[] => {

        const playerCharacter = getCharacterFromPlayer(player);
        const playerHumanoidRootPart = playerCharacter.FindFirstChild("HumanoidRootPart") as BasePart;
        
        const position = playerHumanoidRootPart.Position;
        const lookVector = playerHumanoidRootPart.CFrame.LookVector;
        const right = playerHumanoidRootPart.CFrame.RightVector;
        const up = playerHumanoidRootPart.CFrame.UpVector;

        const node1Position = position.add(lookVector.mul(2)).add(right.mul(2)).add(up.mul(1));
        const node2Position = node1Position.add(lookVector.mul(20));
        const node3Position = node2Position.add(lookVector.mul(5).add(up.mul(-4)));

        const nodes: BasePart[] = [
            createNode(node1Position), // start
            createNode(node2Position), // direct
            createNode(node3Position), // direct + down
        ];

        return nodes;
    },
    
    touchedEffectAttack: (otherPart: BasePart, owner: Player): [boolean, EnemyData | undefined] => {
        if ( otherPart === undefined ) return [false, undefined];

        const ownerCharacter = getCharacterFromPlayer(owner);

        // hitbox explosion
        const hitbox = new Instance("Part");
        hitbox.Parent = Workspace;
        hitbox.Size = new Vector3(4, 4, 4);
        hitbox.Position = otherPart.Position
        hitbox.Color = Color3.fromRGB(170, 0, 0);
        hitbox.Transparency = 0.8
        hitbox.Anchored = true;
        hitbox.CanCollide = false;
        hitbox.CanTouch = false;

        const overlapParams = new OverlapParams();
        overlapParams.FilterType = Enum.RaycastFilterType.Exclude

        const parts = Workspace.GetPartsInPart(hitbox, overlapParams);
        if ( parts[0] === undefined ) return [false, undefined];

        for (const i of parts) {
            if ( i.Parent !== undefined ) {
                const character = i.Parent as Model;
                if ( character === ownerCharacter ) return [false, undefined];
                
                const humanoid = i.Parent.FindFirstChild("Humanoid") as Humanoid;
                if ( humanoid !== undefined ) {

                    const armore = i.Parent.GetAttribute(GameConfig.ARMORE_ATTRIBUTE) as number ?? 0;
                    const data: EnemyData = {
                        character: character,
                        humanoid: humanoid, 
                        armore: armore,
                    }
                    

                    // hitbox.Destroy();
                    return [true, data];
                }
            }
        }
        
        // hitbox.Destroy();
        return [false, undefined];
    },

}