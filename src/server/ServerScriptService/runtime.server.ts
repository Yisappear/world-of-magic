import { ServerStorage } from "@rbxts/services";
import initialize from "shared/Modules/Utils/Initialize";

// folders
const Modules = ServerStorage.FindFirstChild("Modules") as Folder;


// setup
initialize(Modules);