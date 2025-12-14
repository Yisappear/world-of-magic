import React from "@rbxts/react";

interface Props {
    visible: boolean,
    onClick: VoidFunction,
}

export default function SellButton(props: Props): React.Element {
    return (
        <textbutton
            Position={ UDim2.fromScale(0.05, 0.82) }
            Size={ UDim2.fromScale(0.9, 0.1) }
            BackgroundColor3={ Color3.fromRGB(0, 191, 255) }
            BackgroundTransparency={ 0 }
            Visible={ props.visible }
            ClipsDescendants={ false }

            Text={ "Sell" }
            FontFace={ new Font("Ubuntu", Enum.FontWeight.Bold) }
            TextColor3={ Color3.fromRGB(0, 0, 0) }
            TextScaled={ true }

            Event={ { MouseButton1Click: () => { props.onClick() } } }
        >
            <uicorner CornerRadius={ new UDim(0, 10) } />
            <uistroke Thickness={ 2 } />
        </textbutton>
    )
}