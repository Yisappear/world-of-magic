import { RunService, Workspace, ReplicatedStorage, Players } from "@rbxts/services";
import GameConfig from "shared/Modules/Configs/GameConfig";
import Network from "shared/Modules/Network";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";

// folders
const Modules = ReplicatedStorage.WaitForChild("Modules") as Folder;
const Configs = Modules.FindFirstChild("Configs") as Folder;
const WeaponConfigs = Configs.FindFirstChild("Weapons") as Folder;

// constants
const projectiles: ProjectileData[] = [];

// private functions
function isDamageKill(enemyHumanoid: Humanoid, enemyArmore: number, weaponDamage: number): boolean {

    if ( enemyHumanoid.Health === 0) return false

    let isDamage = false;
    let isKill = false;

    const currentHealth = enemyHumanoid.Health;

    const damage = currentHealth - (weaponDamage - enemyArmore);
    
    const newHealth = math.max(damage, 0);
    enemyHumanoid.Health = newHealth;
    isDamage = true;

    if ( newHealth === 0 ) {
        isKill = true;
        return isKill;
    }

    return isKill;
}

function cleanup(createTime: number): void {
    for ( const object of projectiles ) {
        if ( object.createTime === createTime ) {
            const idx = projectiles.findIndex(obj => obj.createTime === createTime);
            projectiles[idx].model.Destroy();
            projectiles.remove(idx);
        }
    }
}

function getHitbox(projectile: BasePart): BasePart {
    const part = new Instance("Part");
    part.Parent = Workspace;
    part.Size = projectile.Size;
    part.CanCollide = false;
    part.Transparency = 0.5;
    part.Color = new Color3(170, 0, 0);
    part.Anchored = true;

    return part;
}

function onAttack(player: Player): void {

    const createTime = Workspace.GetServerTimeNow();
    
    const weaponName = player.GetAttribute(GameConfig.WEAPON_ATTRIBUTE) as string ?? GameConfig.FIRE_STAFF as string;
    const configModule = require(WeaponConfigs.FindFirstChild(`${weaponName}` + "Config") as ModuleScript) as { default: WeaponConfig };
    const config = configModule.default as WeaponConfig;
    if ( configModule === undefined || config === undefined ) return;

    // cooldown
    const cooldown = player.GetAttribute(GameConfig.COOLDOWN) as number ?? 0;
    const lastWeapon = player.GetAttribute(GameConfig.LAST_WEAPON);
    if ( (createTime - cooldown) < config.cooldown && lastWeapon === weaponName) return;
    player.SetAttribute(GameConfig.COOLDOWN, createTime);
    player.SetAttribute(GameConfig.LAST_WEAPON, weaponName);

    // create hitbox
    const model = getHitbox(config.projectileModel);
    const nodes = config.getPath(player);
    projectiles.push({
        config: config,
        owner: player,
        createTime: createTime,
        model: model,
        speed: config.projectileSpeed,
        nodes: nodes,
    });

    // touched event
    const playerCharacter = getCharacterFromPlayer(player);
    let isTouched = false;
    const connection = model.Touched.Connect(otherPart => {
        if ( otherPart.Parent === playerCharacter  || otherPart.Parent === undefined ) return;

        isTouched = true;
        cleanup(createTime);

        const [isDamage, enemyData] = config.touchedEffect(otherPart.Parent);
        if ( isDamage === true ) {

            const isKill = isDamageKill(enemyData.humanoid, enemyData.armore, config.damage);
            if ( isKill === true ) {
                task.spawn(() => {
                    // reward
                    
                });
            }
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
            const [finished, cf] = object.config.moveAtPath(
                distanceTraveled,
                object.nodes,
            );

            if ( finished === true ) {
                cleanup(object.createTime);
                object.config.touchedEffect(object.model);
            }

            p.push(object.model);
            cfs.push(cf);
        }
    }

    if ( p[0] === undefined || cfs[0] === undefined ) return;
    Workspace.BulkMoveTo(p, cfs, Enum.BulkMoveMode.FireCFrameChanged);
});

Network.AttackEvent.OnServerEvent.Connect(onAttack);