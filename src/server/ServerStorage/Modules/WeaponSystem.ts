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
function notification(): void {
    Network.RenderEvent.FireAllClients();
}

function rewardPerKill(player: Player): void {

}

function isDamageAndKill(
    enemyHumanoid: Humanoid,
    enemyArmore: number,
    weaponDamage: number,
): [boolean, boolean] {

    let isDamage = false;
    let isKill = false;

    const currentHealth = enemyHumanoid.Health;

    const damage = currentHealth - (weaponDamage - enemyArmore);
    
    const newHealth = math.max(damage, 0);
    enemyHumanoid.Health = newHealth;
    isDamage = true;

    if ( newHealth === 0 ) {
        isKill = true;
        return [isDamage, isKill];
    }

    return [isDamage, isKill];
}

function cleanup(model: BasePart): void {
    for ( const object of projectiles ) {
        if ( object.model === model ) {
            const idx = projectiles.findIndex(obj => obj.model === model);
            projectiles[idx].model.Destroy();
            projectiles.remove(idx);
        }
    }
}

function getServerProjectile(projectile: BasePart): BasePart {
    const part = new Instance("Part");
    part.Parent = Workspace;
    part.Size = projectile.Size;
    part.CanCollide = false;

    return part;
}

function onAttack(player: Player): void {
    const weaponName = player.GetAttribute(GameConfig.WEAPON_ATTRIBUTE) as string ?? GameConfig.FIRE_STAFF as string;
    const config = require(WeaponConfigs.FindFirstChild(`${weaponName}` + "Config") as ModuleScript) as WeaponConfig;

    const model = getServerProjectile(config.projectileModel);
    const cf = config.getStartPosition(player);

    const startPosition = cf.Position;
    const direction = cf.LookVector;

    const playerCharacter = getCharacterFromPlayer(player);
    
    projectiles.push({
        config: config,
        owner: player,
        createTime: Workspace.GetServerTimeNow(),
        model: model,
        speed: config.projectileSpeed,
        startPosition: startPosition,
        direction: direction,
    })

    model.Touched.Connect(otherPart => {
        if ( otherPart.Parent === playerCharacter ) return;

        cleanup(model);
        
        const enemyCharacter = otherPart.Parent
        const enemyHumanoid = enemyCharacter?.FindFirstChild("Humanoid") as Humanoid;
        const enemyPlayer = Players.GetPlayerFromCharacter(enemyCharacter);
        let enemyArmore = 0;

        if ( enemyHumanoid === undefined ) return;
        if ( enemyPlayer !== undefined ) {
            enemyArmore = enemyPlayer.GetAttribute(GameConfig.ARMORE_ATTRIBUTE) as number ?? 0;
        }

        task.spawn(() => {
            const [isDamage, isKill] = isDamageAndKill(
                enemyHumanoid,
                enemyArmore,
                config.damage,
            )

            if ( isDamage === false ) {
                warn(`isDamage, got false`)
            }

            if ( isKill === true ) {
                rewardPerKill(player);
            }
        })
    })

    notification();
}

// setup
RunService.Stepped.Connect(() => {

    const p: BasePart[] = [];
    const cfs: CFrame[] = [];

    // move projectiles
    for (const object of projectiles) {
        if ( projectiles[0] === undefined ) return;
        if ( object.model.Parent !== undefined ) {
            
            const cf = object.config.getMovePosition(
                object.createTime,
                object.speed,
                object.startPosition,
                object.direction,
            );

            p.push(object.model);
            cfs.push(cf);
        }
    }

    if ( p[0] === undefined || cfs[0] === undefined ) return;
    Workspace.BulkMoveTo(p, cfs, Enum.BulkMoveMode.FireCFrameChanged);
});

Network.AttackEvent.OnServerEvent.Connect((player: Player, args) => {onAttack(player);});