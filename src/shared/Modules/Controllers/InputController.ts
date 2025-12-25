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

    function onAbilityZ(actionName: string, state: Enum.UserInputState, inputObject: InputObject) {
        Network.AbilityEvent.FireServer("Z")
    }
    function onAbilityX(actionName: string, state: Enum.UserInputState, inputObject: InputObject) {
        Network.AbilityEvent.FireServer("X")
    }

    // bind CAS
    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch);
    ContextActionService.BindAction("AbilityZ", onAbilityZ, false, Enum.KeyCode.Z);
    ContextActionService.BindAction("AbilityX", onAbilityX, false, Enum.KeyCode.X);
}

function onUnequipWeapon(): void {
    // unbind CAS
    ContextActionService.UnbindAction("Attack");
    ContextActionService.UnbindAction("AbilityZ");
    ContextActionService.UnbindAction("AbilityX");
}

// setup
Network.WeaponEquipEvent.OnClientEvent.Connect(onEquipWeapon);
Network.WeaponUnequipEvent.OnClientEvent.Connect(onUnequipWeapon);