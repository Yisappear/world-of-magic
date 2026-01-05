import { Workspace, RunService, ReplicatedStorage } from "@rbxts/services";
import Network from "shared/Modules/Network";
import BasicStaff from "shared/Modules/Content/Weapons/BasicStaff";
import { getPlayerStruct } from "./Player";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";

// types
type Projectile = {
    createTime: number,
    speed: number,
    model: BasePart,
    nodes: BasePart[],
}

// module logic
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

function damageToEnemy(humanoid: Humanoid, damage: number) {

    const hlth = humanoid.Health - damage; // todo: rename
    const newHealth = math.max(hlth, 0);
    humanoid.Health = newHealth;
}

function getWeaponConfig(player: Player): weapon | undefined | string {
    const playerStruct = getPlayerStruct(player);
    if ( !playerStruct ) {
        player.Kick("Game end. :P");
        return undefined;
    }

    const inventory = playerStruct.data.inventory as Inventory;
    const equipped = inventory.equipped;
    
    let weaponName = ""
    for (const i of equipped) {
        if ( i.itemType === "Weapon") {
            weaponName =  i.itemName;
        }
    }

    const module = require(ReplicatedStorage
        .FindFirstChild("Modules")
        ?.FindFirstChild("Contens")
        ?.FindFirstChild("Weapons")
        ?.FindFirstChild(weaponName) as ModuleScript) as { default: weapon};
    if ( !module ) throw` ${weaponName}, config doesn't exist `;

    const config = module.default;
    return config;
}

function onAttack(player: Player): void {

    const t = Workspace.GetServerTimeNow();

    // debug get basic config
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

    const ownerCharacter = getCharacterFromPlayer(player);

    let hasTouched = false;
    const connection = model.Touched.Connect(otherPart => {
        if ( hasTouched ) return;
        if ( otherPart.Parent === ownerCharacter ) return;

        hasTouched = true;

        // cleanup
        const idx = projectiles.findIndex(v => v.createTime === t);
        projectiles.remove(idx);
        model.Destroy();
        
        const enemyCharacter = otherPart.Parent as Model;
        const enemyHumanoid = enemyCharacter.FindFirstChild("Humanoid") as Humanoid;
        if ( enemyCharacter && enemyHumanoid ) {
            damageToEnemy(enemyHumanoid, damage);
        }

        connection.Disconnect();
        return;
    });
}

function onAbility(player: Player, keyword: "first" | "second"): void {

    const t = Workspace.GetServerTimeNow();

    // get config from profile data equipped items


    let hasNodes: boolean = false;
    let nodes!: BasePart[];
    let touchedFunction!: TouchedFunction;
    if ( keyword === "first" ) {
        const [has, list, func] = BasicStaff.firstAbility(player);
        hasNodes = has as boolean;
        nodes = list as BasePart[];
        touchedFunction = func as TouchedFunction;
    }
    if ( keyword === "second" ) {
        const [has, list, func] = BasicStaff.secondAbility(player);
        hasNodes = has as boolean;
        nodes = list as BasePart[];
        touchedFunction = func as TouchedFunction;
    }
    if ( !hasNodes ) return;

    // debug get basic config
    const damage = BasicStaff.firstAbilityDamage;
    const speed = BasicStaff.firstAbilitySpeed;
    const model = BasicStaff.firstAbilityProjectileModel.Clone();
    model.Parent = Workspace; model.Color = Color3.fromRGB(220, 0, 0); 

    // object for movement
    projectiles.push({
        createTime: t,
        speed: speed,
        model: model,
        nodes: nodes,
    });

    const ownerCharacter = getCharacterFromPlayer(player);

    let hasTouched = false;
    const connection = model.Touched.Connect(otherPart => {
        if ( hasTouched ) return;
        if ( otherPart.Parent === ownerCharacter ) return;

        hasTouched = true;

        // cleanup
        const idx = projectiles.findIndex(v => v.createTime === t);
        projectiles.remove(idx);
        model.Destroy();

        const [isTouchEnemy, enemyHumanoid] = touchedFunction(otherPart);
        if ( isTouchEnemy && enemyHumanoid ) {
            damageToEnemy(enemyHumanoid, damage);
        }
        
        connection.Disconnect();
        return;
    });

}

// setup
RunService.Stepped.Connect(() => {

    const t = Workspace.GetServerTimeNow();

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
Network.Ability.OnServerEvent.Connect((player, args) => { 
    if ( !args ) return;
    const data = args as "first" | "second";
    onAbility(player, data);
});