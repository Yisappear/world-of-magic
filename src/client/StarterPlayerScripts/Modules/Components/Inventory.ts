import ClientConfig from "shared/Modules/Configs/ClientConfig";
import React from "@rbxts/react";
import ReactRoblox from "@rbxts/react-roblox";
import InventoryComponent from "shared/Ui/Inventory";

const inventory = React.createElement(InventoryComponent, {});

const root = ReactRoblox.createRoot(ClientConfig.PLAYER_GUI);
root.render(inventory)