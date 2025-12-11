import React from "@rbxts/react";

interface Props {

}

export default function CountFrame(props: Props): React.Element {
    return (
        <frame
            Size={ UDim2.fromScale(0.4, 0.15) }
            Position={ UDim2.fromScale(0.515, -0.02) }
            BackgroundColor3={ Color3.fromRGB(0, 191, 255) }
            BackgroundTransparency={ 0 }
            Visible={ true }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 1 } />

            <imagelabel
                Size={ UDim2.fromScale(0.15, 0.8) }
                Position={ UDim2.fromScale(0.05, 0.1) }
                Visible={ true }
            />

            <imagelabel
                Size={ UDim2.fromScale(0.15, 0.8) }
                Position={ UDim2.fromScale(0.55, 0.1) }
                Visible={ true }
            />

            <textlabel
                Size={ UDim2.fromScale(0.3, 0.45) }
                Position={ UDim2.fromScale(0.2, 0.3) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                Text={ `0/10` }
                Font={ "FredokaOne" }
                TextScaled={ true }
                TextColor3={ Color3.fromRGB(255, 255, 255) }
            >
                <uistroke Thickness={ 1 } />
            </textlabel>

            <textlabel
                Size={ UDim2.fromScale(0.3, 0.45) }
                Position={ UDim2.fromScale(0.7, 0.3) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                Text={ `0/10` }
                Font={ "FredokaOne" }
                TextScaled={ true }
                TextColor3={ Color3.fromRGB(255, 255, 255) }
            >
                <uistroke Thickness={ 1 } />
            </textlabel>  
        </frame>
    )
}