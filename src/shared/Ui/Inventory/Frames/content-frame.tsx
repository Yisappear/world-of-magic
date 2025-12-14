import React from "@rbxts/react";
import EquippedFrame from "./equipped-frame";
import InventoryFrame from "./inventory-frame";

interface Props {

}

export default function ContentFrame(props: Props): React.Element {
    return (
        <frame
            Position={ UDim2.fromScale(0, 0) }
            Size={ UDim2.fromScale(1, 1) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ true }
        >
            <scrollingframe
                Position={ UDim2.fromScale(0, 0.1) }
                Size={ UDim2.fromScale(1, 0.9) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                ClipsDescendants={ false }
            >
                <uilistlayout />
                <uipadding />

                <EquippedFrame />
                <InventoryFrame />
                

            </scrollingframe>

        </frame>
    )
}