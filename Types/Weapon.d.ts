type TouchedFunction = (otherPart: BasePart) => [boolean, Humanoid] | [boolean, undefined];

type Ability = [boolean, BasePart[], TouchedFunction] | [boolean, undefined, undefined];
