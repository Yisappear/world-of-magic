import { ContextActionService } from "@rbxts/services";
import Network from "shared/Modules/Network";

function onEquip(): void {

    let lastClick = 0;

    function onClick(actionName: string, state: Enum.UserInputState, inputObject: InputObject) {
        
        const t = os.clock();
        if ( (t - lastClick) < 0.5 ) return; // anti double click
        lastClick = t;

        Network.AttackEvent.FireServer();
    }

    // bind CAS
    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch);
}

function onUnequip(): void {
    // unbind CAS
    ContextActionService.UnbindAction("Attack");
}

// setup
Network.EquipWeaponEvent.OnClientEvent.Connect(onEquip);
Network.UnequipWeaponEvent.OnClientEvent.Connect(onUnequip);