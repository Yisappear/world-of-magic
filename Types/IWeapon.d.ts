interface WeaponConfig {
    model: BasePart | MeshPart,
    damage: number,
    cooldown: number,
    animation: string,
    icon: string,
    projectileModel: BasePart | MeshPart,
    projectileSpeed: number,
    getPath: (player: Player) => BasePart[],
    moveAtPath: (distanceTraveled: number, nodes: BasePart[]) => [boolean, CFrame],
    touchedEffect: (otherPart: Instance) => [boolean, EnemyData],
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
    humanoid: Humanoid,
    armore: number,
}