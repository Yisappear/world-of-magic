import React from "@rbxts/react";

interface Props {
    visible: boolean,


    [key: string]: any // children
}

export default function MainFrame(props: Props): React.Element {
    return (
        <frame
            Position={ UDim2.fromScale(0.23, 0.23) }
            Size={ UDim2.fromScale(0.4, 0.6) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 0.6 }
            Visible={ props.visible }
            ClipsDescendants={ false }
        >
            <uicorner CornerRadius={ new UDim(0, 15)  } />
            <uistroke Thickness={ 3 } />

            {props["children"]}
        </frame>
    )
}