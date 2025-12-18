import { HttpService } from "@rbxts/services";
import React from "@rbxts/react";
import TextInventoryContent from "../Labels/text-inventorycontent";
import Network from "shared/Modules/Network";
import WeaponItemButton from "../Buttons/weapon-item-button";
import ArmoreItemButton from "../Buttons/armore-item-button";

interface Props {
    onClick1: VoidFunction,
    onClick2: VoidFunction,
}

export default function InventoryFrame(props: Props): React.Element {

    // hooks
    const [armores, setArmore] = React.useState<Item[]>([]);
    const [weapons, setWeapon] = React.useState<Item[]>([]);
    React.useEffect(() => {

        const addConnection = Network.AddItemEvent.OnClientEvent.Connect(args => {
            const item = args as AddItemData;

            if ( item.itemType === "Weapon" ) {
                setWeapon(prev => [
                    ...prev, 
                    {
                        uuid: item.itemUUID,
                        icon: item.itemIcon,
                    },
                ])
            }
            if ( item.itemType === "Armore" ) {
                setArmore(prev => [
                    ...prev, 
                    {
                        uuid: item.itemUUID,
                        icon: item.itemIcon,
                    },
                ])
            }
        });

        const delConnection = Network.DelItemEvent.OnClientEvent.Connect(args => {
            const item = args as DelItemData;

            if ( item.itemType === "Weapon" ) {
                setWeapon(prev => prev.filter(i => i.uuid !== item.itemUUID));
            }
            if ( item.itemType === "Armore" ) {
                setArmore(prev => prev.filter(i => i.uuid !== item.itemUUID));
            }
        });

        return (() => {
            addConnection.Disconnect();
            delConnection.Disconnect();
        })
    }, []);



    return (
        <frame
            Size={ UDim2.fromScale(1, 1) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ false }
        >
            
            <TextInventoryContent />

            <frame
                Position={ UDim2.fromScale(0, 0) }
                Size={ UDim2.fromScale(1, 1) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                ClipsDescendants={ false }
            >
                <uigridlayout
                    CellPadding={ new UDim2(0, 5, 0, 5) }
                    CellSize={ new UDim2(0.15, 0, 1, 0) }
                >
                    <uiaspectratioconstraint />
                </uigridlayout>

                {weapons.map(button => (
                    <WeaponItemButton
                        key={ button.uuid }
                        icon={ button.icon }
                        onClick={ () => { print("you click on weapon item") } }
                    />
                ))}

                {armores.map(button => (
                    <ArmoreItemButton
                        key={ button.uuid }
                        icon={ button.icon }
                        onClick={ () => { print("you click on armore item") } }
                    />
                ))}

            </frame>
        </frame>
    )
}