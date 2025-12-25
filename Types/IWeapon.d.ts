interface WeaponConfig {
    model: BasePart | MeshPart,
    damage: number,
    cooldown: number,
    animation: string,
    icon: string,
    rewardMult: number,
    projectileModel: BasePart | MeshPart,
    projectileSpeed: number,
    abilityZModel: BasePart | MeshPart,
    abilityZSpeed: number,
    getPathAttack: (player: Player) => BasePart[],
    touchedEffectAttack: (otherPart: Instance, owner: Player) => [boolean, EnemyData],
    abilityZ: (owner: Player) => [boolean, BasePart[]];
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