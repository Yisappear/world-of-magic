import React from "@rbxts/react";

interface Props {
    onClick: VoidFunction,
}

export default function CloseButton(props: Props): React.Element {
    return (
        <imagebutton
            Size={ UDim2.fromScale(0.1, 0.15) }
            Position={ UDim2.fromScale(0.92, -0.02) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            Visible={ true }
            Event={ { MouseButton1Click: () => { props.onClick() } } }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 1 } />

            <textlabel
                Size={ UDim2.fromScale(1, 0.3) }
                Position={ UDim2.fromScale(0, 0.35) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                Text={ "Close" }
                Font={ "FredokaOne" }
                TextScaled={ true }
                TextColor3={ Color3.fromRGB(0, 0, 0) }
            >
            </textlabel>
        </imagebutton>
    )
}