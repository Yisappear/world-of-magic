import React from "@rbxts/react";
import Network from "shared/Modules/Network";

interface Props {
    onClick: VoidFunction,
}

export default function CloseButton(props: Props): React.Element {
    return (
        <imagebutton
            Position={ UDim2.fromScale(0.87, -0.02) }
            Size={ UDim2.fromScale(0.15, 0.15) }
            BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
            BackgroundTransparency={ 0 }
            Visible={ true }
            ClipsDescendants={ false }
            Event={ { MouseButton1Click: () => { 
                props.onClick();
                Network.CloseInventoryEvent.Fire();
            }
            } }
        >

            <textlabel
                Position={ UDim2.fromScale(0.2, 0.3) }
                Size={ UDim2.fromScale(0.65, 0.25) }
                BackgroundColor3={ Color3.fromRGB(255, 255, 255) }
                BackgroundTransparency={ 1 }
                Visible={ true }
                ClipsDescendants={ false }

                Text={ "Close" }
                FontFace={ new Font("Ubuntu", Enum.FontWeight.Bold) }
                TextColor3={ Color3.fromRGB(0, 0, 0) }
                TextScaled={ true }
            />

        </imagebutton>
    )
}