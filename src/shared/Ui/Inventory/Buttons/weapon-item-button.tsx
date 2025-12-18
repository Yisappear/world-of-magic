import React from "@rbxts/react";

interface Props {
    icon: string,
    onClick: VoidFunction,
}

export default function WeaponItemButton(props: Props): React.Element {
    return (
        <imagebutton
            Image={ props.icon }
            Event={ { MouseButton1Click:() => { props.onClick() } } }
        >
            <uisizeconstraint MinSize={ new Vector2(117, 117) } />

        </imagebutton>
    )
}