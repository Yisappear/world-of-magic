interface WeaponConfig {
    model: BasePart | MeshPart,
    damage: number,
    cooldown: number,
    animation: string,
    icon: string,
    projectileModel: BasePart | MeshPart,
    projectileSpeed: number,
    rewardMult: number,
    getPathAttack: (player: Player) => BasePart[],
    touchedEffectAttack: (otherPart: Instance) => [boolean, EnemyData],
}

interface ProjectileData {
    config: WeaponConfig,
    owner: Player,
    createTime: number,
    model: BasePart,
    speed: number,
    nodes: BasePart[],
}

interface EnemyData {
    character: Model,
    humanoid: Humanoid,
    armore: number,
}