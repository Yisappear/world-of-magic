import React from "@rbxts/react";

interface Props {

}

export default function TextInventoryContent(props: Props): React.Element {
    return (
        <textlabel
            Position={ UDim2.fromScale(0.37, -0.05) }
            Size={ UDim2.fromScale(0.25, 0.04) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 1 }
            Visible={ true }
            ClipsDescendants={ false }

            Text={ "Inventory" }
            Font={ "Highway" }
            TextColor3={ Color3.fromRGB(255, 255, 255) }
            TextScaled={ true }
        >
            <uistroke Thickness={ 2 } Color={ Color3.fromRGB(190, 190, 190) } />
        </textlabel>
    )
}