type TouchedFunction = (otherPart: BasePart) => [boolean, Humanoid] | [boolean, undefined];

type Ability = [boolean, BasePart[], TouchedFunction] | [boolean, undefined, undefined];

interface weapon {

    staffModel: BasePart,
    projectileModel: BasePart,
    damage: number,
    speed: number,
    firstAbilityProjectileModel: BasePart,
    firstAbilityDamage: number,
    firstAbilitySpeed: number,
    secondAbilityProjectileModel: BasePart,
    secondAbilityDamage: number,
    secondAbilitySpeed: number,
    getNodesAttack: (player: Player) => BasePart[],
    firstAbility: (player: Player) => Ability,
    secondAbility: (player: Player) => Ability,
}