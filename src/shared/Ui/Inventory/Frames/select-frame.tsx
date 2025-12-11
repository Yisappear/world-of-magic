import React from "@rbxts/react";

interface Props {
    voidSelect: boolean,
    itemSelect: boolean,
}

export default function SelectFrame(props: Props): React.Element {
    return (
        <frame
            Size={ UDim2.fromScale(0.25, 0.8) }
            Position={ UDim2.fromScale(0.735, 0.15) }
            BackgroundColor3={ Color3.fromRGB(0, 191, 255) }
            BackgroundTransparency={ 0 }
            Visible={ true }
        >
            <uicorner CornerRadius={ new UDim(0, 15) } />
            <uistroke Thickness={ 1 } />

            <frame
                Size={ UDim2.fromScale(1, 1) }
                Position={ UDim2.fromScale(0, 0) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ props.voidSelect }
            >
                
                <textlabel
                    Size={ UDim2.fromScale(0.8, 0.2) }
                    Position={ UDim2.fromScale(0.1, 0.35) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    BackgroundTransparency={ 1 }
                    Visible={ true }
                    Text={ "Select an item" }
                    Font={ "Highway" }
                    TextScaled={ true }
                    TextColor3={ Color3.fromRGB(0, 0, 0) }
                >

                </textlabel>
            </frame>

            <frame
                Size={ UDim2.fromScale(1, 1) }
                Position={ UDim2.fromScale(0, 0) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ props.itemSelect }
            >

                <imagelabel
                    Size={ UDim2.fromScale(0.7, 0.37) }
                    Position={ UDim2.fromScale(0.15, 0.09) }
                    Visible={ true }
                    Image={ "" }
                >
                </imagelabel>

                <textlabel
                    Size={ UDim2.fromScale(0.7, 0.1) }
                    Position={ UDim2.fromScale(0.15, 0.02) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    BackgroundTransparency={ 1 }
                    Visible={ true }
                    Text={ "Name" }
                    Font={ "FredokaOne" }
                    TextScaled={ true }
                    TextColor3={ Color3.fromRGB(255, 255, 255) }
                >
                    <uistroke Thickness={ 1 } />
                </textlabel>

                <textlabel
                    Size={ UDim2.fromScale(0.4, 0.1) }
                    Position={ UDim2.fromScale(0.02, 0.47) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    BackgroundTransparency={ 1 }
                    Visible={ true }
                    Text={ "Damage:" }
                    Font={ "FredokaOne" }
                    TextScaled={ true }
                    TextColor3={ Color3.fromRGB(255, 255, 255) }
                >
                    <uistroke Thickness={ 1 } />
                </textlabel>

                <textlabel
                    Size={ UDim2.fromScale(0.4, 0.1) }
                    Position={ UDim2.fromScale(0.02, 0.47) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    BackgroundTransparency={ 1 }
                    Visible={ true }
                    Text={ "Armore:" }
                    Font={ "FredokaOne" }
                    TextScaled={ true }
                    TextColor3={ Color3.fromRGB(255, 255, 255) }
                >
                    <uistroke Thickness={ 1 } />
                </textlabel>

                <imagebutton
                    Size={ UDim2.fromScale(0.9, 0.1) }
                    Position={ UDim2.fromScale(0.05, 0.72) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    Visible={ true }
                    Event={ { MouseButton1Click: () => {  } } }
                >
                    <uicorner CornerRadius={ new UDim(0, 7) } />
                    <uistroke Thickness={ 1 } />

                    <textlabel
                        Size={ UDim2.fromScale(1, 0.8) }
                        Position={ UDim2.fromScale(0, 0.1) }
                        BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                        BackgroundTransparency={ 1 }
                        Visible={ true }
                        Text={ "Equip" }
                        Font={ "FredokaOne" }
                        TextScaled={ true }
                        TextColor3={ Color3.fromRGB(255, 255, 255) }
                    >
                        <uistroke Thickness={ 1 } />
                    </textlabel>
                </imagebutton>

                <imagebutton
                    Size={ UDim2.fromScale(0.9, 0.1) }
                    Position={ UDim2.fromScale(0.05, 0.84) }
                    BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                    Visible={ true }
                    Event={ { MouseButton1Click: () => {  } } }
                >
                    <uicorner CornerRadius={ new UDim(0, 7) } />
                    <uistroke Thickness={ 1 } />

                    <textlabel
                        Size={ UDim2.fromScale(1, 0.8) }
                        Position={ UDim2.fromScale(0, 0.1) }
                        BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                        BackgroundTransparency={ 1 }
                        Visible={ true }
                        Text={ "Delete" }
                        Font={ "FredokaOne" }
                        TextScaled={ true }
                        TextColor3={ Color3.fromRGB(255, 255, 255) }
                    >
                        <uistroke Thickness={ 1 } />
                    </textlabel>
                </imagebutton>
            </frame>
        </frame>
    )
}