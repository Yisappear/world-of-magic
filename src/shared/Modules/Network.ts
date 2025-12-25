import { ReplicatedStorage, RunService } from "@rbxts/services";

// folders
const Events = ReplicatedStorage.WaitForChild("Events") as Folder;
const InventoryEvents = Events.FindFirstChild("InventoryEvents") as Folder;
const WeaponEvents = Events.FindFirstChild("WeaponEvents") as Folder;
const ProjectileEvents = Events.FindFirstChild("ProjectilesEvents") as Folder;

// private functions
function getEvent(name: string, folder: Folder, eventType: "RemoteEvent" | "RemoteFunction" | "BindableEvent" | "BindableFunction") {

    const isEvent = folder.FindFirstChild(name);
    if ( isEvent !== undefined) return isEvent;

    if ( RunService.IsClient() === true ) {
        const isEvent = folder.WaitForChild(name) as RemoteEvent | RemoteFunction;
        if ( isEvent !== undefined) return isEvent;

        throw`client event got null: ${name}, ${folder}, ${eventType}`
    }

    if ( RunService.IsServer() === true ) {
        const isFolder = folder as Folder;
        if ( isFolder === undefined ) throw`foler for events got undefined FolderName: ${folder.Name}`
    
        const event = new Instance(eventType);
        event.Parent = folder;
        event.Name = name;
    
        return event;
    } 
}

// setup
export default {

    // RemoteEvents

        // Weapon
            AttackEvent: getEvent("Attack", WeaponEvents, "RemoteEvent") as RemoteEvent, 
            AbilityEvent: getEvent("Ability", WeaponEvents, "RemoteEvent") as RemoteEvent,           

        // Projectile
            RenderEvent: getEvent("Render", ProjectileEvents, "RemoteEvent") as RemoteEvent,


        // Inventory
            LoadInventoryEvent: getEvent("LoadInventory", InventoryEvents, "BindableEvent") as BindableEvent,
            GiveItemToPlayerEvent: getEvent("GiveItemToPlayer", InventoryEvents, "BindableEvent") as BindableEvent,
            NewItemEvent: getEvent("NewItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            DelItemEvent: getEvent("DelItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            EquipItemEvent: getEvent("EquipItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            UnequipItemEvent: getEvent("UnequipItem", InventoryEvents, "RemoteEvent") as RemoteEvent,
            IsEquipped: getEvent("IsEquipped", InventoryEvents, "RemoteFunction") as RemoteFunction,
            SelectItemEvent: getEvent("SelectItem", InventoryEvents, "BindableEvent") as BindableEvent,
            CloseInventoryEvent: getEvent("CloseInventory", InventoryEvents, "BindableEvent") as BindableEvent,
            UpdateWeaponFrameEvent: getEvent("UpdateWeaponFrame", InventoryEvents, "BindableEvent") as BindableEvent,

            // Weapon
                WeaponEquipEvent: getEvent("WeaponEquip", InventoryEvents, "RemoteEvent") as RemoteEvent,
                WeaponUnequipEvent: getEvent("WeaponUnequip", InventoryEvents, "RemoteEvent") as RemoteEvent,
            // Armore
                ArmoreEquipEvent: getEvent("ArmoreEquip", InventoryEvents, "RemoteEvent") as RemoteEvent,

    // RemoteFunctions

    // BindableEvents (client)

    // BindableFunctions (client)

}