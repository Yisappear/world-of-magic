import React from "@rbxts/react";

interface Props {
    visible: boolean
}

export default function MainFrame(props: Props): React.Element {
    return (
        <frame
            Size={ UDim2.fromScale(0.715, 0.615) }
            Position={ UDim2.fromScale(0.215, 0.2) }
            BackgroundColor3={ Color3.fromRGB(242, 242, 242) }
            Visible={ props.visible }
        >
            <uicorner CornerRadius={ new UDim(0, 25) } />
            <uistroke Thickness={ 2 } />
        </frame>
    )
}