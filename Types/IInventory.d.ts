
type ItemType = "Weapon" | "Armore" 

interface Item {
    name: string,
    itemType: ItemType,
    armoreType?: "Hat" | "Torse" | "Legs",
    equipped: boolean,
}

interface ItemData { //  ->  type ItemKey = string // for find or get from inventory
    uuid: string,
    name: string,
    itemType: ItemType,
}

interface ClientItemData extends ItemData {
    icon: string
}