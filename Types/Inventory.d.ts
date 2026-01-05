interface item {
    uuid: string,
    itemType: "Weapon" | "Armore",
    armoreType?: "Hat" | "Torso" | "Pants",
    itemName: string,
    equipped: boolean,
}


interface Inventory {
    equipped: item[],
    unequipped: item[],
}