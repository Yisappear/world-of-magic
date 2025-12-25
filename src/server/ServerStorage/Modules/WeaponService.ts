import { RunService, Workspace, ReplicatedStorage } from "@rbxts/services";
import GameConfig from "shared/Modules/Configs/GameConfig";
import Network from "shared/Modules/Network";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";
import { rewardForKill } from "./RewardService";

// folders
const Modules = ReplicatedStorage.WaitForChild("Modules") as Folder;
const Content = Modules.FindFirstChild("Content") as Folder;
const Weapons = Content.FindFirstChild("Weapons") as Folder;

// arrays
const projectiles: ProjectileData[] = [];

// private functions
function damage(enemyData: EnemyData, player: Player, config: WeaponConfig) {

    if ( enemyData.humanoid.Health === 0) return false

    let isKill = false;

    const currentHealth = enemyData.humanoid.Health;

    const damage = currentHealth - (config.damage - enemyData.armore);
    
    const newHealth = math.max(damage, 0);
    enemyData.humanoid.Health = newHealth;

    if ( newHealth === 0 ) {
        task.spawn(() => {

            rewardForKill(
                player,
                10 * config.rewardMult,
                enemyData.character.Name,
            )
        });
    }

    return isKill;
}

function cleanup(createTime: number, nodes: BasePart[]): void {
    for ( const object of projectiles ) {
        if ( object.createTime === createTime ) {
            const idx = projectiles.findIndex(obj => obj.createTime === createTime);
            projectiles[idx].model.Destroy();
            projectiles.remove(idx);
        }
    }
    for (const i of nodes) {
        i.Destroy();
    }
}

function getPositionAtPath(nodes: BasePart[], distanceTraveled: number): [boolean, CFrame] {

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
}

function onAbility(player: Player, abilityKey: "Z" | "X") {

    const createTime = Workspace.GetServerTimeNow();
    
    const weaponName = player.GetAttribute(GameConfig.WEAPON_ATTRIBUTE) as string;
    if ( weaponName === undefined ) return;

    const configModule = require(Weapons.FindFirstChild(weaponName) as ModuleScript) as { default: WeaponConfig };
    const config = configModule.default as WeaponConfig;
    if ( configModule === undefined || config === undefined ) return;

    const model = new Instance("Part");
    model.Parent = Workspace;
    model.Position = Vector3.one;
    model.Size = config.abilityZModel.Size;
    model.CanCollide = false;
    model.Transparency = 0.5;
    model.Color = new Color3(170, 0, 0);
    model.Anchored = true;

    const speed = config.abilityZSpeed;

    let nodes!: BasePart[];

    if ( abilityKey === "Z" ) {
        const [hasMove, path] = config.abilityZ(player);
        if ( hasMove === false ) return;
        nodes = path;
    }
    
    if ( nodes === undefined ) {
        model.Destroy();
    };

    projectiles.push({
        config: config,
        owner: player,
        createTime: createTime,
        model: model,
        speed: speed,
        nodes: nodes,
    })

    // const playerCharacter: Model = getCharacterFromPlayer(player);
    // let isTouched: boolean = false;
    // const connection = model.Touched.Connect(otherPart => {
    //     if ( isTouched === true || otherPart.Parent === playerCharacter  || otherPart.Parent === undefined ) return;

    //     isTouched = true;
    //     cleanup(createTime, nodes);

    //     const [isDamage, enemyData] = config.touchedEffectAttack(otherPart, player);
    //     if ( isDamage === true ) {

    //         damage(enemyData, player, config);
    //     }
        
    //     connection.Disconnect();
    // })

}

function onAttack(player: Player): void {

    const createTime = Workspace.GetServerTimeNow();
    
    const weaponName = player.GetAttribute(GameConfig.WEAPON_ATTRIBUTE) as string;
    if ( weaponName === undefined ) return;

    const configModule = require(Weapons.FindFirstChild(weaponName) as ModuleScript) as { default: WeaponConfig };
    const config = configModule.default as WeaponConfig;
    if ( configModule === undefined || config === undefined ) return;

    // cooldown
    const cooldown = player.GetAttribute(GameConfig.COOLDOWN) as number ?? 0;
    const lastWeapon = player.GetAttribute(GameConfig.LAST_WEAPON);
    if ( (createTime - cooldown) < config.cooldown && lastWeapon === weaponName) return;

    player.SetAttribute(GameConfig.COOLDOWN, createTime);
    player.SetAttribute(GameConfig.LAST_WEAPON, weaponName);

    const model = new Instance("Part");
    model.Parent = Workspace;
    model.Size = config.projectileModel.Size;
    model.CanCollide = false;
    model.Transparency = 0.5;
    model.Color = new Color3(170, 0, 0);
    model.Anchored = true;

    const nodes = config.getPathAttack(player);
    projectiles.push({
        config: config,
        owner: player,
        createTime: createTime,
        model: model,
        speed: config.projectileSpeed,
        nodes: nodes,
    });

    // touched event
    const playerCharacter: Model = getCharacterFromPlayer(player);
    let isTouched: boolean = false;
    const connection = model.Touched.Connect(otherPart => {
        if ( isTouched === true || otherPart.Parent === playerCharacter  || otherPart.Parent === undefined ) return;

        isTouched = true;
        cleanup(createTime, nodes);

        const [isDamage, enemyData] = config.touchedEffectAttack(otherPart, player);
        if ( isDamage === true ) {

            damage(enemyData, player, config);
        }
        
        connection.Disconnect();
    })

    // client render

}

// setup
RunService.Stepped.Connect(() => {

    const p: BasePart[] = [];
    const cfs: CFrame[] = [];

    // move projectiles
    for (const object of projectiles) {
        if ( projectiles[0] === undefined ) return;
        if ( object.model.Parent !== undefined ) {
            
            const t = Workspace.GetServerTimeNow();
            const distanceTraveled = (t - object.createTime) * object.speed;
            const [finished, cf] = getPositionAtPath(
                object.nodes,
                distanceTraveled,
            );

            if ( finished === true ) {
                cleanup(object.createTime, object.nodes);
                object.config.touchedEffectAttack(object.model, object.owner);
            }

            p.push(object.model);
            cfs.push(cf);
        }
    }

    if ( p[0] === undefined || cfs[0] === undefined ) return;
    Workspace.BulkMoveTo(p, cfs, Enum.BulkMoveMode.FireCFrameChanged);
});

Network.AttackEvent.OnServerEvent.Connect(onAttack);
Network.AbilityEvent.OnServerEvent.Connect((player, args) => {
    if ( args === undefined ) return;

    const key = args as "Z" | "X";
    onAbility(player, key);
})