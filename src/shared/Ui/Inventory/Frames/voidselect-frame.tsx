import React from "@rbxts/react";
import TextVoidSelect from "../Labels/text-voidselect";

interface Props {
    visible: boolean,
}

export default function VoidSelectFrame(props: Props): React.Element {
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

            <TextVoidSelect />

        </frame>
    )
}