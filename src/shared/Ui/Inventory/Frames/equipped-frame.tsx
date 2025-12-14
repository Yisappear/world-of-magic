import React from "@rbxts/react";
import TextEquipped from "../Labels/text-equipped";

interface Props {

}

export default function EquippedFrame(props: Props): React.Element {
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
                    CellSize={ new UDim2(0.2, 0, 1, 0) }
                >
                    <uiaspectratioconstraint />
                </uigridlayout>
            </frame>
        </frame>
    )
}