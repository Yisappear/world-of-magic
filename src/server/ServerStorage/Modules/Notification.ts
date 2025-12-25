import Network from "shared/Modules/Network";

export function notifyKillReward(player: Player, amount: number, enemyName: string) {

    const sendData = {}

    const notifyMSG = `reward: ${amount} cash, for destroy: ${enemyName}`;

    // remote

}

export function notifyAddItem(player: Player, itemName: string) {

    const sendData = {}

    const notifyMSG = `new item: ${itemName}`;

    // remote

}

export function notifyDelItem(player: Player, itemName: string) {

    const sendData = {}

    const notifyMSG = `delete item: ${itemName}`;

    // remote

}

export function notifySellItem(player: Player, itemName: string) {

}

export function notifyEquipppedState(player: Player, state: boolean) {

}

export function notifyHitEnemy(player: Player) {

    // sound for player and ui at center

}