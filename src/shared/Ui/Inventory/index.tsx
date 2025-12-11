import React from "@rbxts/react";
import { changeMainFrameVisbile } from "./hooks";
import MainFrame from "./Frames/main-frame";
import CloseButton from "./Buttons/close-button";
import EquipBestButton from "./Buttons/equip-best-button";
import TextFrame from "./Frames/text-frame";
import CountFrame from "./Frames/count-frame";
import SelectFrame from "./Frames/select-frame";

// types
type booleanStateHook = [boolean, VoidFunction];

// hooks
const [mVisible, changeMVisible] = changeMainFrameVisbile() as booleanStateHook;

interface Props {

}

export default function App(props: Props): React.Element {
    return (
        <screengui ResetOnSpawn={ false }>
            <MainFrame visible={ mVisible } >

                <CloseButton onClick={ changeMVisible } />
                <EquipBestButton onClick={ changeMVisible } />

                <TextFrame/>
                <CountFrame/>
                <SelectFrame voidSelect={ true } itemSelect={ false } />

            </MainFrame>
        </screengui>
    )
}