interface Item {
    uuid: string, // create in config
    equipped: boolean,
}

interface IInventory {
    weapons: {string: Item}
}