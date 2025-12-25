import { Workspace } from "@rbxts/services";

export function getCharacterFromPlayer(player: Player) {
    if ( player === undefined ) throw"why u call this function without player parametr"
    return player.Character ?? player.CharacterAdded.Wait()[0];
}

export function createNode(pos: Vector3): BasePart {
    const node = new Instance("Part");
    node.Parent = Workspace;
    node.Size = new Vector3(1, 1, 1);
    node.Position = pos;
    node.Transparency = 0.5
    node.CanCollide = false;
    node.CanTouch = false;
    node.Anchored = true;

    return node;
}