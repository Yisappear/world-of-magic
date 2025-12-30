import { Workspace, RunService } from "@rbxts/services";
import Network from "shared/Modules/Network";
import BasicStaff from "shared/Modules/Content/Weapons/BasicStaff";

// types
type Projectile = {
    createTime: number,
    speed: number,
    model: BasePart,
    nodes: BasePart[],
}

// private variables
// setup array for moving parts
const projectiles: Projectile[] = [];

// private functions
function getPositionAtPath(treveledDistance: number, nodes: BasePart[]): [boolean, CFrame] {
    
    let sektor = 0;
    for (let i = 2; i < nodes.size() + 1; i += 1) {
        const p0 = nodes[i - 2].Position;
        const p1 = nodes[i - 1].Position;
        const newSektor = sektor + (p0.sub(p1)).Magnitude;

        if ( newSektor > treveledDistance ) {
            const alpha = math.map(treveledDistance, sektor, newSektor, 0, 1);
            return [false, CFrame.lookAlong(p0.Lerp(p1, alpha), p1.sub(p0))];
        }
        sektor = newSektor;
    }

    const p0 = nodes[nodes.size() - 2].Position;
    const p1 = nodes[nodes.size() - 1].Position;
    return [true, CFrame.lookAlong(p1, p1.sub(p0))];
}

function onAttack(player: Player): void {

    const t = Workspace.GetServerTimeNow();

    // debug get basic
    const damage = BasicStaff.damage;
    const speed = BasicStaff.speed;
    const model = BasicStaff.projectileModel.Clone();
    model.Parent = Workspace; model.Color = Color3.fromRGB(220, 0, 0); 
    const nodes = BasicStaff.getNodesAttack(player);

    // create object for movement
    projectiles.push({
        createTime: t,
        speed: speed,
        model: model,
        nodes: nodes,
    });

    function damageToEnemy(humanoid: Humanoid) {

        const hlth = humanoid.Health - damage; // todo: rename
        const newHealth = math.max(hlth, 0);

        print(newHealth)

        humanoid.Health = newHealth;
    }

    let hasTouched = false;
    const connection = model.Touched.Connect(otherPart => {
        if ( hasTouched ) return;

        hasTouched = true;

        // cleanup
        const idx = projectiles.findIndex(v => v.createTime === t);
        projectiles.remove(idx);
        model.Destroy();
        
        const enemyCharacter = otherPart.Parent as Model;
        const enemyHumanoid = enemyCharacter.FindFirstChild("Humanoid") as Humanoid;
        if ( enemyCharacter && enemyHumanoid ) {
            damageToEnemy(enemyHumanoid);
        }

        connection.Disconnect();
        return;
    });
}

function onAbility(player: Player, keycode: "Z" | "X"): void {


    // TODO: how to release




    const isMoving = BasicStaff.getNodesAbilityZ(player);

}

// setup
RunService.Stepped.Connect(() => {

    const t = Workspace.GetServerTimeNow()

    const parts: BasePart[] = [];
    const cfs: CFrame[] = [];

    // loop for moving parts
    for (const i of projectiles) {
        const treveledDistance = (t - i.createTime) * i.speed;
        const [isFinished, cframe] = getPositionAtPath(
            treveledDistance,
            i.nodes,
        )

        if ( isFinished ) {

            // cleanup
            const idx = projectiles.findIndex(v => v.createTime === i.createTime);
            projectiles.remove(idx);
            i.model.Destroy();

            continue;
        }

        parts.push(i.model);
        cfs.push(cframe);      
    }

    if ( !parts[0] && !cfs[0] ) return;
    Workspace.BulkMoveTo(parts, cfs, Enum.BulkMoveMode.FireCFrameChanged);
})


// network
Network.Attack.OnServerEvent.Connect(onAttack)
// Network.Ability.OnServerEvent.Connect((player, args) => { onAbility(player, args) });