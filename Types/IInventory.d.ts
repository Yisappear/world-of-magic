interface Item {
    name: string,
    itemType: "Weapon" | "Armore",
    armoreType?: "Hat" | "Torse" | "Legs",
    equipped: boolean,
}

type ItemType = "Weapon" | "Armore" 

interface ItemData {
    uuid: string,
    name: string,
    itemType: ItemType,
}

interface ClientItemData extends ItemData {
    icon: string
}