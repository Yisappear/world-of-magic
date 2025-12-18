import { ContextActionService, RunService } from "@rbxts/services";
import Network from "shared/Modules/Network";



function renderWeapon() {}





function onEquip(name: string): void {

    function onClick() {
        Network.AttackEvent.FireServer();
    }

    // bind CAS
    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1);
}

function onUnequip(): void {
    // unbind CAS
    ContextActionService.UnbindAction("Attack");
}
