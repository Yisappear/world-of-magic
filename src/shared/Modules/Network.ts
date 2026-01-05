import { ReplicatedStorage, RunService } from "@rbxts/services";

// types
type event = "RemoteEvent" | "RemoteFunction" | "BindableEvent" | "BindableFunction";
type Ievent = RemoteEvent | RemoteFunction | BindableEvent | BindableFunction;

// folders
const Events = ReplicatedStorage.WaitForChild("Events") as Folder;
const RoundEvents = Events.FindFirstChild("RoundEvents") as Folder;
const WeaponEvents = Events.FindFirstChild("WeaponEvents") as Folder;

// private functions
function getEvent(eventName: string, folder: Folder, eventType: event): Ievent {
    const hasEvent = folder.FindFirstChild(eventName) as Ievent;
    if ( hasEvent !== undefined ) return hasEvent;

    if ( RunService.IsServer() ) {
        const event = new Instance(eventType);
        event.Name = eventName;
        event.Parent = folder;
        return event;
    }

    const eventForClient = folder.WaitForChild(eventName) as Ievent;
    return eventForClient;
}

export default {

    // Round
        JoinToGameEvent: getEvent("JoinToGame", RoundEvents, "RemoteEvent") as RemoteEvent,

    // WeaponEvents folder
        Attack: getEvent("Attack", WeaponEvents, "RemoteEvent") as RemoteEvent,
        Ability: getEvent("Ability", WeaponEvents, "RemoteEvent") as RemoteEvent,


}