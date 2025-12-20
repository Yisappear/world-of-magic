import React from "@rbxts/react";

interface Props {
    visible: boolean,
    onClick: VoidFunction,
}

export default function EquipButton(props: Props): React.Element {
    return (
        <textbutton
            Position={ UDim2.fromScale(0.05, 0.7) }
            Size={ UDim2.fromScale(0.9, 0.1) }
            BackgroundColor3={ Color3.fromRGB(0, 170, 0) }
            BackgroundTransparency={ 0 }
            Visible={ props.visible }
            ClipsDescendants={ false }

            Text={ "Equip" }
            FontFace={ new Font("Ubuntu", Enum.FontWeight.Bold) }
            TextColor3={ Color3.fromRGB(255, 255, 255) }
            TextScaled={ true }

            Event={ { MouseButton1Click: () => { props.onClick() } } }
        >
            <uicorner CornerRadius={ new UDim(0, 10) } />
            <uistroke Thickness={ 2 } />
        </textbutton>
    )
}