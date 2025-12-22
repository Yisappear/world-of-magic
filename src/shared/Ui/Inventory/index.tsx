import React from "@rbxts/react";
import MainFrame from "./Frames/main-frame";
import TextInventory from "./Labels/text-inventorymain";
import CloseButton from "./Buttons/close-button";
import ContentFrame from "./Frames/content-frame";
import VoidSelectFrame from "./Frames/voidselect-frame";
import WeaponSelectFrame from "./Frames/weaponselect-frame";

interface Props {

}

export default function App(props: Props): React.Element {
    // hooks
    // main frame
    const [mainFrameVisible, mainFrame] = React.useState(true);
    const changeMainFrameVisible = () => mainFrame((v) => !v);

    // void select frame
    const [voidSelectFrameVisible, voidSelect] = React.useState(true);
    const changeVoidSelectVisible = () => voidSelect((v) => !v);

    // select frame
    const [selectFrameVisible, selectFrame] = React.useState(true);
    const changeSelectVisible = () => selectFrame((v) => !v);

    

    return (
        <screengui ResetOnSpawn={ false } >
            <MainFrame visible={ mainFrameVisible } >

                <TextInventory />
                <CloseButton onClick={ changeMainFrameVisible } />

                <ContentFrame 
                    onClick1={ changeVoidSelectVisible }
                    onClick2={ changeSelectVisible }
                />

                <VoidSelectFrame visible={ voidSelectFrameVisible } />
                <WeaponSelectFrame visible={ selectFrameVisible } voidSelectFramVisible={ voidSelect } />

            </MainFrame>
        </screengui>
    )
}