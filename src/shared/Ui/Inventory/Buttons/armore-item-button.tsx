import React from "@rbxts/react";
import Network from "shared/Modules/Network";

interface Props {
    icon: string,
    onClick: VoidFunction,
}

export default function ArmoreItemButton(props: Props): React.Element {

    const ref = React.useRef<ImageButton>();
    React.useEffect(() => {

        const button = ref.current;
        if ( button === undefined ) return;

        const connection = button.GetPropertyChangedSignal("AbsoluteSize").Connect(() => {
            Network.UpdateWeaponFrameEvent.Fire(button.AbsoluteSize)
        });

        return () => {
            connection.Disconnect();
        }

    }, [])

    return (
        <imagebutton
            ref={ ref }
            Image={ props.icon }
            Event={ { MouseButton1Click:() => { props.onClick() } } }

        >

        </imagebutton>
    )
}