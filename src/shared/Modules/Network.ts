import { ReplicatedStorage, RunService } from "@rbxts/services";

// folders
const Events = ReplicatedStorage.WaitForChild("Events") as Folder;
const InventoryEvents = Events.FindFirstChild("InventoryEvents") as Folder;
const WeaponEvents = Events.FindFirstChild("WeaponEvents") as Folder;
const ProjectileEvents = Events.FindFirstChild("ProjectilesEvents") as Folder;

// private functions
function getEvent(name: string, folder: Folder, eventType: "RemoteEvent" | "RemoteFunction" | "BindableEvent" | "BindableFunction") {

    const isEvent = folder.FindFirstChild(name) as RemoteEvent | RemoteFunction;
    if ( isEvent !== undefined) return isEvent;

    if ( RunService.IsClient() === true ) {
        const isEvent = folder?.WaitForChild(name) as RemoteEvent | RemoteFunction;
        if ( isEvent !== undefined) return isEvent;

        throw`client event got null: ${name}, ${folder}, ${eventType}`
    }

    if ( RunService.IsServer() === true ) {
        const isFolder = folder as Folder;
        if ( isFolder === undefined ) throw`foler for events fot undefined FolderName: ${folder.Name}`
    
        const event = new Instance(eventType);
        event.Parent = isFolder;
        event.Name = name;
    
        return event;
    } 
}

// setup
export default {

    // RemoteEvents

        // Weapon
            AttackEvent: getEvent("Attack", WeaponEvents, "RemoteEvent") as RemoteEvent,            

        // Projectile
            RenderEvent: getEvent("Render", ProjectileEvents, "RemoteEvent") as RemoteEvent,


        // Inventory
            AddItemEvent: getEvent("AddItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            GiveItemEvent: getEvent("GiveItem", InventoryEvents, "BindableEvent") as BindableEvent,
            DelItemEvent: getEvent("DelItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            EquipItemEvent: getEvent("EquipItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            UnequipItemEvent: getEvent("UnequipItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            SelectItemEvent: getEvent("SelectItem", InventoryEvents, "BindableEvent") as BindableEvent,
            IsEquipped: getEvent("IsEquipped", InventoryEvents, "RemoteFunction") as RemoteFunction,
            CloseInventoryEvent: getEvent("CloseInventory", InventoryEvents, "BindableEvent") as BindableEvent,

            // Weapon
                EquipWeaponEvent: getEvent("EquipWeapon", InventoryEvents, "RemoteEvent") as RemoteEvent,
                UnequipWeaponEvent: getEvent("UnequipWeapon", InventoryEvents, "RemoteEvent") as RemoteEvent,
            // Armore
                EquipArmoreEvent: getEvent("EquipArmore", InventoryEvents, "RemoteEvent") as RemoteEvent,

    // RemoteFunctions

    // BindableEvents (client)

    // BindableFunctions (client)

}