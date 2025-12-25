import { ReplicatedStorage } from "@rbxts/services";
import initialize from "shared/Modules/Utils/Initialize";

// folders
const Modules = ReplicatedStorage.FindFirstChild("Modules") as Folder;
const Controllers = Modules.FindFirstChild("Controllers") as Folder;

// setup
initialize(Controllers);