import React from "@rbxts/react";

interface Props {

}

export default function TextFrame(props: Props): React.Element {
    return (
        <frame
            Size={ UDim2.fromScale(0.5, 0.2) }
            Position={ UDim2.fromScale(-0.1, -0.05) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
        >

            <textlabel
                Size={ UDim2.fromScale(1, 1) }
                Position={ UDim2.fromScale(0, 0) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                Text={ "RAWR!!!" }
                Font={ "FredokaOne" }
                TextScaled={ true }
                TextColor3={ Color3.fromRGB(65, 105, 225) }
            >
                <uistroke Thickness={ 1 } />
            </textlabel>
        </frame>
    )
}