import { Workspace } from "@rbxts/services";

// types
interface Directions {
    positionVector: Vector3;
    lookVector: Vector3;
    upVector: Vector3;
    rightVector: Vector3;
}


// export
export function getCharacterFromPlayer(player: Player): Model {
    return player.Character ?? player.CharacterAdded.Wait()[0];
}

export function getCharacterDirectionVectors(player: Player): Directions {
    const character = getCharacterFromPlayer(player);
    const humanoidRootPart = character.FindFirstChild("HumanoidRootPart") as BasePart;
    const hrpCFrame = humanoidRootPart.CFrame;
    const hrpPosition = hrpCFrame.Position;

    const lookVector = hrpCFrame.LookVector;
    const upVector = hrpCFrame.UpVector;
    const rightVector = hrpCFrame.RightVector;

    return {
        positionVector: hrpPosition,
        lookVector: lookVector,
        upVector: upVector,
        rightVector: rightVector,
    }
}

export function createNode(pos: Vector3): BasePart {
    const part = new Instance("Part");
    part.Parent = Workspace;
    part.Size = Vector3.one;
    part.Position = pos;
    part.Transparency = 0.5;
    part.Anchored = true;
    part.CanCollide = false;
    part.CanTouch = false;

    return part;
}

export function createLeaderstatsForPlayer(player: Player): void {

    const leaderstats = new Instance("Folder") as Folder;
    leaderstats.Name = "leaderstats";

    const cash = new Instance("NumberValue") as NumberValue;
    cash.Name = "Cash";
    cash.Value = 0;

    leaderstats.Parent = player;
    cash.Parent = leaderstats;
    
}