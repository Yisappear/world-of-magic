import React from "@rbxts/react";

interface Props {
    icon: string,
    onClick: VoidFunction,
}

export default function EquippedItemButton(props: Props): React.Element {
    return (
        <imagebutton
            Image={ props.icon }
            Event={ { MouseButton1Click: () => { props.onClick() } } }
        >

        </imagebutton>
    )
}