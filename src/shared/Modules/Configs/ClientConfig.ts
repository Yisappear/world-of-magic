import { Players, RunService } from "@rbxts/services";
if ( RunService.IsClient() === false ) throw"don't client??";

const player = Players.LocalPlayer;

export default {

    LOCAL_PLAYER: player,
    USER_ID: player.UserId,
    PLAYER_GUI: player.WaitForChild("PlayerGui"),
    PLAYER_SCRIPTS: player.FindFirstChild("PlayerScripts"),

    GET_CHARACTER: () => {
        return player.Character ?? player.CharacterAdded.Wait()[0] 
    }

}