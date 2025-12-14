import React from "@rbxts/react";

interface Props {

}

export default function TextClose(props: Props): React.Element {
    return (
        <textlabel
            Position={ UDim2.fromScale(0, -0.07) }
            Size={ UDim2.fromScale(0.45, 0.15) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ false }

            Text={ "Close" }
            FontFace={ new Font("Ubuntu", Enum.FontWeight.Bold) }
            TextColor3={ Color3.fromRGB(0, 0, 0) }
            TextScaled={ true }
        >

        </textlabel>
    )
}