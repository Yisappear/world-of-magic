import React from "@rbxts/react";
// import { changeMainFrameVisbile } from "./hooks";
import MainFrame from "./Frames/main-frame";
import CloseButton from "./Buttons/close-button";
import EquipBestButton from "./Buttons/equip-best-button";
import TextFrame from "./Frames/text-frame";
import CountFrame from "./Frames/count-frame";
import SelectFrame from "./Frames/select-frame";

// types
type booleanStateHook = [boolean, VoidFunction];


// hooks
// function changeMainFrameVisbile() {
//     const [mVisible, changeState] = React.useState(false);
//     const changeMVisible = () => changeState((v) => !v);

//     return $tuple(mVisible, changeMVisible);
// }


interface Props {

}

export default function App(props: Props): React.Element {

    // hooks
    const [mVisible, changeState] = React.useState(true);
    const changeMVisible = () => changeState((v) => !v);

    return (
        <screengui ResetOnSpawn={ false } >
            <MainFrame visible={ mVisible } >

                <CloseButton onClick={ changeMVisible } />
                <EquipBestButton onClick={ changeMVisible } />

                <TextFrame />
                <CountFrame />
                <SelectFrame voidSelect={ true } itemSelect={ false } />

            </MainFrame>
        </screengui>
    )
}