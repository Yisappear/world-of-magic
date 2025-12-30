import { ReplicatedStorage } from "@rbxts/services";
import { createNode, getCharacterDirectionVectors } from "shared/Modules/Utils/Helper";

// private variables
const Assets = ReplicatedStorage.WaitForChild("Assets").FindFirstChild("Weapons") as Folder;
const staffModel = Assets?.FindFirstChild("BasicStaff") as BasePart;
const projectileModel = Assets?.FindFirstChild("Fireball") as BasePart;

// export
export default {

    staffModel: staffModel,
    projectileModel: projectileModel,

    damage: 20,
    speed: 4,

    getNodesAttack(player: Player): BasePart[] {
        const directions = getCharacterDirectionVectors(player);
        
        return [
            createNode(directions.positionVector.add(directions.lookVector.mul(4))), // start position
            createNode(directions.positionVector.add(directions.lookVector.mul(24))),
            createNode(directions.positionVector.add(directions.lookVector.mul(28).add(directions.upVector.mul(-30)))), // end position
        ]
    },

    getNodesAbilityZ(player: Player) {


    },
}