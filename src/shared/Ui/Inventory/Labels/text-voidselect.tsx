import React from "@rbxts/react";

interface Props {

}

export default function TextVoidSelect(props: Props): React.Element {
    return (
        <textlabel
            Position={ UDim2.fromScale(0, 0.3) }
            Size={ UDim2.fromScale(1, 0.4) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ false }

            Text={ "Select any item" }
            FontFace={ new Font("Ubuntu", Enum.FontWeight.Bold) }
            TextColor3={ Color3.fromRGB(0, 0, 0) }
            TextScaled={ true }
        >
            
        </textlabel>
    )
}