import React from "@rbxts/react";
import EquipButton from "../Buttons/equip-button";
import SellButton from "../Buttons/sell-button";
import UnequipButton from "../Buttons/unequip-button";

interface Props {
    visible: boolean
}

export default function WeaponSelectFrame(props: Props): React.Element {
    return (
        <frame
            Position={ UDim2.fromScale(1.05, 0) }
            Size={ UDim2.fromScale(0.5, 1) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 0.6 }
            Visible={ props.visible }
            ClipsDescendants={ false }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 3 } />

            <frame
                Position={ UDim2.fromScale(0, 0) }
                Size={ UDim2.fromScale(1, 1) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                ClipsDescendants={ false }
            >

                <EquipButton onClick={ () => {} } visible={ true } />
                <UnequipButton onClick={ () => {} } visible={ false } />
                <SellButton onClick={ () => {} } visible={ true } />

            </frame>

        </frame>
    )
}