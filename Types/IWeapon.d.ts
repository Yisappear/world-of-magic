interface WeaponConfig {
    model: BasePart | MeshPart,
    damage: number,
    cooldown: number,
    animation: string,
    projectileModel: BasePart | MeshPart,
    projectileSpeed: number,
    getStartPosition: (player: Player) => [Vector3, Vector3],
    getMovePosition: (createTime: number, speed: number, startPosition: Vector3, direction: Vector3) => CFrame,
}

interface ProjectileData {
    config: WeaponConfig,
    owner: Player,
    createTime: number,
    model: BasePart,
    speed: number,
    startPosition: Vector3,
    direction: Vector3,
}