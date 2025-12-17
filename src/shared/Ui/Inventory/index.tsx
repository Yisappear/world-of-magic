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

    return (
        <screengui ResetOnSpawn={ false } >
            <MainFrame visible={ mainFrameVisible } >

                <TextInventory />
                <CloseButton onClick={ changeMainFrameVisible } />

                <ContentFrame />

                <VoidSelectFrame visible={ true } />
                <WeaponSelectFrame visible={ false } />


            </MainFrame>
        </screengui>
    )
}