import React from "@rbxts/react";
import EquipButton from "../Buttons/equip-button";
import SellButton from "../Buttons/sell-button";
import UnequipButton from "../Buttons/unequip-button";
import Network from "shared/Modules/Network";
import VoidSelectFrame from "./voidselect-frame";

interface Props {
    visible: boolean
    voidSelectFramVisible: (bool: boolean) => void,
}

export default function WeaponSelectFrame(props: Props): React.Element {

    // equip button
    const [equipVision, equipButton] = React.useState(true);

    // vision
    const [frameVision, selectFrame] = React.useState(false);

    const refExample = {
        uuid: "aaa",
        name: "FireStaff",
        itemType: "Weapon",
    } as ItemData;

    const dataRef = React.useRef<ItemData>(refExample)
    React.useEffect(() => {

        Network.SelectItemEvent.Event.Connect((args: ItemData) => {
            props.voidSelectFramVisible(false);
            selectFrame(true)
            if ( args === undefined ) return;
            const data = args as ItemData;
            dataRef.current = data;

            equipButton(true);

            const equipped = Network.IsEquipped.InvokeServer(data.uuid) as boolean;
            if ( equipped === true ) equipButton(false);
        });

        Network.CloseInventoryEvent.Event.Connect(() => {
            selectFrame(false);
            props.voidSelectFramVisible(true);
            equipButton(true);
            dataRef.current = refExample;
        });

    }, [ dataRef ])

    return (
        <frame
            Position={ UDim2.fromScale(1.05, 0) }
            Size={ UDim2.fromScale(0.5, 1) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 0.6 }
            Visible={ frameVision }
            ClipsDescendants={ false }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 3 } />

            <frame
                Position={ UDim2.fromScale(0, 0) }
                Size={ UDim2.fromScale(1, 1) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ frameVision }
                ClipsDescendants={ false }
            >

                <EquipButton onClick={ () => { Network.EquipItemEvent.FireServer(dataRef.current);} } visible={ equipVision } />
                <UnequipButton onClick={ () => { Network.UnequipItemEvent.FireServer(dataRef.current); } } visible={ !equipVision } />
                <SellButton onClick={ () => { Network.DelItemEvent.FireServer(dataRef.current); } } visible={ true } />

            </frame>

        </frame>
    )
}