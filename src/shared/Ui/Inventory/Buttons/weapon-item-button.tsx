import React from "@rbxts/react";
import Network from "shared/Modules/Network";

interface Props {
    icon: string,
    onClick: VoidFunction,
}

export default function WeaponItemButton(props: Props): React.Element {

    const [stateVector, changeVector] = React.useState<Vector2>(new Vector2(76, 76))
    React.useEffect(() => {

        const connection = Network.UpdateWeaponFrameEvent.Event.Connect((args: Vector2) => {
            if ( args === undefined ) return;
            const aVector = args;
            const Value = aVector.X * 2;
            changeVector(new Vector2(Value, Value));
        })

        return () => {
            connection.Disconnect();
        }

    }, [])

    return (
        <imagebutton
            Image={ props.icon }
            Event={ { MouseButton1Click:() => { props.onClick() } } }
        >
            <uisizeconstraint MinSize={ stateVector } />

        </imagebutton>
    )
}