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
const meteorite = WeaponAssets.FindFirstChild("Meteorite") as BasePart;

export default {

    model: fireStaff,
    damage: 20,
    cooldown: 1.5,
    animation: "",
    icon: "",

    rewardMult: 1,

    projectileModel: fireball,
    projectileSpeed: 21,

    abilityZModel: meteorite,
    abilityZSpeed: 11,
    abilityZcantouch: {
        // whats can touched
    },


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
        hitbox.Transparency = 0.77
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

    abilityZ: (owner: Player): [boolean, BasePart[]] => {
        // metorite auto-target

        // todo cooldown
        // check mana


        const ownerCharacter = getCharacterFromPlayer(owner);
        const ownerPosition = (ownerCharacter.FindFirstChild("HumanoidRootPart") as BasePart).CFrame.Position;

        // find enemy
        const findPart = new Instance("Part");
        findPart.Parent = Workspace;
        findPart.Position = ownerPosition;
        findPart.Size = new Vector3(30, 30, 30);
        findPart.Color = Color3.fromRGB(0, 200, 0);
        findPart.Transparency = 0.8;
        findPart.Anchored = true;
        findPart.CanCollide = false;
        findPart.CanTouch = false;

        const overlapParams = new OverlapParams();
        overlapParams.FilterType = Enum.RaycastFilterType.Exclude;
        overlapParams.FilterDescendantsInstances = [ ownerCharacter,  ]

        
        let distance = 999;
        let enemyPosition!: Vector3;
        
        const parts = Workspace.GetPartsInPart(findPart, overlapParams);
        for (const part of parts) {
            const parent = part.Parent;
            const humanoid = parent?.FindFirstChild("Humanoid");
            if ( parent !== undefined && humanoid !== undefined && parent !== ownerCharacter) {
                const enemyPos = (parent.FindFirstChild("HumanoidRootPart") as BasePart).CFrame.Position;

                const magnitude = (ownerPosition.sub(enemyPos)).Magnitude;
                if ( magnitude < distance ) {
                    distance = magnitude;
                    enemyPosition = enemyPos;
                }
            };
        }
        task.delay(3, () => { findPart.Destroy() });
        if ( distance === 999 || enemyPosition === undefined ) return [false, []];



        //  nodes
        const nodes: BasePart[] = [
            createNode(new Vector3(enemyPosition.X, 30, enemyPosition.Z)), // start pos
            createNode(new Vector3(enemyPosition.X, -10, enemyPosition.Z)), // last pos
        ];
        
        return [true, nodes]; // true - yes move with nodes and connet touched
    },

    abilityX: () => {

    },

}