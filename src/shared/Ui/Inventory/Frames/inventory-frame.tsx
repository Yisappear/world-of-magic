import { HttpService, ReplicatedStorage } from "@rbxts/services";
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
    const [armores, setArmore] = React.useState<ClientItemData[]>([]);
    const [weapons, setWeapon] = React.useState<ClientItemData[]>([]);
    React.useEffect(() => {

        const addConnection = Network.AddItemEvent.OnClientEvent.Connect(args => {
            const item = args as ClientItemData;

            function getIcon(itemType: string, name: string): string {
                if ( itemType === "Weapon" ) {
                    const config = require(ReplicatedStorage.FindFirstChild("Modules")?.FindFirstChild("Configs")?.FindFirstChild("Weapons")?.FindFirstChild(name + "Config") as ModuleScript) as WeaponConfig;
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

            if ( item.itemType === "Weapon" ) {
                setWeapon(prev => [
                    ...prev, 
                    {
                        uuid: item.uuid,
                        name: item.name,
                        itemType: item.itemType,
                        icon: getIcon(item.itemType, item.name),
                    },
                ])
            }
            if ( item.itemType === "Armore" ) {
                setArmore(prev => [
                    ...prev, 
                    {
                        uuid: item.uuid,
                        name: item.name,
                        itemType: item.itemType,
                        icon: getIcon(item.itemType, item.name),
                    },
                ])
            }
        });

        const delConnection = Network.DelItemEvent.OnClientEvent.Connect(args => {
            const item = args as ClientItemData;

            if ( item.itemType === "Weapon" ) {
                setWeapon(prev => prev.filter(i => i.uuid !== item.uuid));
            }
            if ( item.itemType === "Armore" ) {
                setArmore(prev => prev.filter(i => i.uuid !== item.uuid));
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
                        onClick={ () => { 
                            const itemData: ItemData = {
                                uuid: button.uuid,
                                name: button.name,
                                itemType: button.itemType,
                            }
                            print(button.uuid)
                            Network.SelectItemEvent.Fire(itemData); 
                        } }
                    />
                ))}

                {armores.map(button => (
                    <ArmoreItemButton
                        key={ button.uuid }
                        icon={ button.icon }
                        onClick={ () => { 
                            const itemData: ItemData = {
                                uuid: button.uuid,
                                name: button.name,
                                itemType: button.itemType,
                            }
                            Network.SelectItemEvent.Fire(itemData); 
                        } }
                    />
                ))}

            </frame>
        </frame>
    )
}