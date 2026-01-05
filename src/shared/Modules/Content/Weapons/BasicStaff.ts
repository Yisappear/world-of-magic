import { ReplicatedStorage } from "@rbxts/services";
import { createNode, getCharacterDirectionVectors } from "shared/Modules/Utils/Helper";

// private variables
const Assets = ReplicatedStorage.WaitForChild("Assets").FindFirstChild("Weapons") as Folder;
const staffModel = Assets?.FindFirstChild("BasicStaff") as BasePart;
const fireball = Assets?.FindFirstChild("Fireball") as BasePart;
const meteorite = Assets?.FindFirstChild("Meteorite") as BasePart;
const fireSword = Assets?.FindFirstChild("FireSword") as BasePart;


// export
export default {

    staffModel: staffModel,

    // attack
    projectileModel: fireball,
    damage: 20,
    speed: 14,

    // first ability
    firstAbilityProjectileModel: meteorite,
    firstAbilityDamage: 40,
    firstAbilitySpeed: 20,

    // second ability
    secondAbilityProjectileModel: fireSword,
    secondAbilityDamage: 60,
    secondAbilitySpeed: 80,



    getNodesAttack(player: Player): BasePart[] {
        const directions = getCharacterDirectionVectors(player);
        
        return [
            createNode(directions.positionVector.add(directions.lookVector.mul(4))), // start position
            createNode(directions.positionVector.add(directions.lookVector.mul(24))),
            createNode(directions.positionVector.add(directions.lookVector.mul(28).add(directions.upVector.mul(-30)))), // end position
        ]
    },

    firstAbility(player: Player): Ability {
        const directions = getCharacterDirectionVectors(player);

        const nodes = [
            createNode(directions.positionVector.add(directions.lookVector.mul(4).add(directions.upVector.mul(20)))), // start position
            createNode(directions.positionVector.add(directions.lookVector.mul(24).add(directions.upVector.mul(-40)))), // end position
        ]

        function touchEffect(otherPart: BasePart): [boolean, Humanoid] | [boolean, undefined] {

            // find enemy from hitbox

            return [false, undefined];
        }

        return [true, nodes, touchEffect];
    },

    secondAbility(player: Player): Ability {

        // todo: fire sword



        return [false, undefined, undefined];
    },
    
}