import ClientConfig from "shared/Modules/Configs/ClientConfig";
import React from "@rbxts/react";
import ReactRoblox from "@rbxts/react-roblox";
import InventoryComponent from "shared/Ui/Inventory";

// UI's
const inventory = React.createElement(InventoryComponent, {});

// setup
const root = ReactRoblox.createRoot(ClientConfig.PLAYER_GUI);
root.render(inventory)