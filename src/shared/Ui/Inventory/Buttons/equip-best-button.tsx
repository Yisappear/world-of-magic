import React from "@rbxts/react";

interface Props {
    onClick: VoidFunction
}

export default function EquipBestButton(props: Props): React.Element {
    return (
        <imagebutton
            Size={ UDim2.fromScale(0.3, 0.1) }
            Position={ UDim2.fromScale(0.02, 0.92) }
            Visible={ true }
            Event={ { MouseButton1Click: () => {  } } }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 1 } />

            <textlabel
                Size={ UDim2.fromScale(1, 1) }
                Position={ UDim2.fromScale(0, 0) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                Text={ "Equip Best" }
                Font={ "Highway" }
                TextColor3={ Color3.fromRGB(255, 255, 255) }
                TextScaled={ true }
            >
                <uistroke Thickness={ 1 } />
            </textlabel>
        </imagebutton>
    )
}