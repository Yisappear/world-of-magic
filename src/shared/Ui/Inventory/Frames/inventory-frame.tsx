import React from "@rbxts/react";
import TextInventoryContent from "../Labels/text-inventorycontent";

interface Props {

}

export default function InventoryFrame(props: Props): React.Element {
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
            </frame>
        </frame>
    )
}