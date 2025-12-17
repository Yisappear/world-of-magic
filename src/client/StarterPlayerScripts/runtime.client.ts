import ClientConfig from "shared/Modules/Configs/ClientConfig";
import initialize from "shared/Modules/Utils/Initialize";

// folders
const Modules = ClientConfig.PLAYER_SCRIPTS?.FindFirstChild("Modules") as Folder;
const Components = Modules.FindFirstChild("Components") as Folder;

// setup
initialize(Modules);
initialize(Components);