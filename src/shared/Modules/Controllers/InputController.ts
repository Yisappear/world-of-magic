import { ContextActionService } from "@rbxts/services";
import Network from "shared/Modules/Network";

// private functions
function onEquipWeapon(): void {

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

function onUnequipWeapon(): void {
    // unbind CAS
    ContextActionService.UnbindAction("Attack");
}

// setup
Network.WeaponEquipEvent.OnClientEvent.Connect(onEquipWeapon);
Network.WeaponUnequipEvent.OnClientEvent.Connect(onUnequipWeapon);