import { ContextActionService, UserInputService } from "@rbxts/services";
import Network from "../Network";

// private functions
function onEquipWeapon() {
    function onClick(actionName: string, state: Enum.UserInputState, inputObject: InputObject) { 
        if ( state === Enum.UserInputState.End ) return;
            Network.Attack.FireServer(); 
    }
    function onFirstAbility(actionName: string, state: Enum.UserInputState, inputObject: InputObject) { 
        if ( state === Enum.UserInputState.End ) return;
        Network.Ability.FireServer("first");
    }
    function onSecondAbility(actionName: string, state: Enum.UserInputState, inputObject: InputObject) {
        if ( state === Enum.UserInputState.End ) return;
        Network.Ability.FireServer("second");
    }

    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1);
    ContextActionService.BindAction("firstAbility", onFirstAbility, false, Enum.KeyCode.Z);
    ContextActionService.BindAction("secondAbility", onSecondAbility, false, Enum.KeyCode.X);
}

function onUnequipWeapon() {
    ContextActionService.UnbindAction("Attack");
    ContextActionService.UnbindAction("firstAbility");
    ContextActionService.UnbindAction("secondAbility");
}

onEquipWeapon();