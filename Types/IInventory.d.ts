interface Item {
    uuid: string,
    icon: string,
}

interface AddItemData {
    itemType: "Weapon" | "Armore",
    itemIcon: string,
    itemUUID: string,
}

interface DelItemData {
    itemType: "Weapon" | "Armore",
    itemUUID: string,
}

interface ItemData {
    itemUUID: string,
    itemIcon: string,
}