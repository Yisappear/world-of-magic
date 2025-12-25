import { ReplicatedStorage } from "@rbxts/services";
import React from "@rbxts/react";
import Network from "shared/Modules/Network";
import TextEquipped from "../Labels/text-equipped";
import EquippedItemButton from "../Buttons/equipped-item-button";

interface Props {
    onClick1: VoidFunction,
    onClick2: VoidFunction,
}

export default function EquippedFrame(props: Props): React.Element {

    // hooks
    const [items, setItem] = React.useState<ClientItemData[]>([]);   
    React.useEffect(() => {

        const equipConnection = Network.EquipItemEvent.OnClientEvent.Connect(args => {
            const item = args as ClientItemData;

           function getIcon(itemType: string, name: string): string {
                if ( itemType === "Weapon" ) {
                    const config = require(ReplicatedStorage.WaitForChild("Modules").FindFirstChild("Content")?.FindFirstChild("Weapons")?.FindFirstChild(name) as ModuleScript) as WeaponConfig;
                    const icon = config.icon;
                    return icon;
                }
                if ( itemType === "Armore" ) {
                    const config = "";
                    const icon = "";
                    return icon;
                }
                return "";
            }

            setItem(prev => [
                ...prev, 
                {
                    uuid: item.uuid,
                    name: item.name,
                    itemType: item.itemType,
                    icon: getIcon(item.itemType, item.name),
                },
            ])
        })

        const unequipConnction = Network.UnequipItemEvent.OnClientEvent.Connect(args => {
            const item = args as ItemData;
            setItem(prev => prev.filter(i => i.uuid !== item.uuid));
        })


        return (() => {
            equipConnection.Disconnect();
            unequipConnction.Disconnect();
        })
    }, []);


    return (
        <frame
            Size={ UDim2.fromScale(1, 0.15) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ false }
        >

            <TextEquipped />

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
                    CellSize={ new UDim2(1/5, 0, 1, 0) }
                >
                    <uiaspectratioconstraint />
                </uigridlayout>

                {items.map(button => (
                    <EquippedItemButton
                        key={ button.uuid }
                        icon={ button.icon }
                        onClick={ () => { Network.SelectItemEvent.Fire(button); } }
                    />
                ))}

            </frame>
        </frame>
    )
}