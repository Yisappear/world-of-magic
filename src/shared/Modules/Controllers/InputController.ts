import { ContextActionService, UserInputService } from "@rbxts/services";
import Network from "../Network";

// private functions
function onEquip() {
    function onClick(actionName: string, state: Enum.UserInputState, inputObject: InputObject) { 
        if ( state === Enum.UserInputState.End ) return;
            Network.Attack.FireServer(); 
    }
    function onAbility(actionName: string, state: Enum.UserInputState, inputObject: InputObject) { 
        if ( state === Enum.UserInputState.End ) return;
        Network.Ability.FireServer();
    }

    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1);
    ContextActionService.BindAction("Ability", onAbility, false, Enum.KeyCode.Z, Enum.KeyCode.X);
}

function onUnequip() {
    ContextActionService.UnbindAction("Attack");
    ContextActionService.UnbindAction("Ability");
}

onEquip();