import { ContextActionService, RunService } from "@rbxts/services";
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
    ContextActionService.BindAction("Attack", onClick, false, Enum.UserInputType.MouseButton1);
}

function onUnequip(): void {
    // unbind CAS
    ContextActionService.UnbindAction("Attack");
}

//TEST
    onEquip();
    task.wait(10)
    print(`Unbind attack test`);
    onUnequip();

// setup
Network.EquipWeaponEvent.OnClientEvent.Connect(args => onEquip());
Network.UnequipWeaponEvent.OnClientEvent.Connect(args => onUnequip());