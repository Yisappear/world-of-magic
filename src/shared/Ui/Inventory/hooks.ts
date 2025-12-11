import React from "@rbxts/react";

// main frame
export function changeMainFrameVisbile() {
    const [mVisible, changeState] = React.useState(false);
    const changeMVisible = () => changeState((v) => !v);

    return $tuple(mVisible, changeMVisible);
}