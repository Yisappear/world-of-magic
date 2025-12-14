import React from "@rbxts/react";
import TextClose from "../Labels/text-close";

interface Props {
    onClick: VoidFunction,
}

export default function CloseButton(props: Props): React.Element {
    return (
        <imagebutton
            Position={ UDim2.fromScale(0.87, -0.02) }
            Size={ UDim2.fromScale(0.15, 0.15) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 0 }
            Visible={ true }
            ClipsDescendants={ false }
            Event={ { MouseButton1Click: () => { props.onClick() } } }
        >

        <TextClose />

        </imagebutton>
    )
}