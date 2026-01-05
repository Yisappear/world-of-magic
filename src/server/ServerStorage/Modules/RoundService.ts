import { Workspace, Players, RunService } from "@rbxts/services";
import Network from "shared/Modules/Network";
import { getCharacterFromPlayer } from "shared/Modules/Utils/Helper";

type PlayingPlayer = {
    player: Player,
    score: number,
}

// constants
const TIMEOUT_TIME: number = 2;
const ROUND_TIME: number = 60;
const PLAYERS_TO_START: number = 2;

const spawnLocations: CFrame[] = [];

// logic
const playingPlayers: PlayingPlayer[] = []

// private functions
function teleportToSpawnLocation(player: Player): void {
    const spawnNumber = math.random(0, spawnLocations.size() - 1);
    const spawn = spawnLocations[spawnNumber];

    const playerCharacter = getCharacterFromPlayer(player);
    const playerHrp = playerCharacter.FindFirstChild("HumanoidRootPart") as BasePart;


    // whats to pick
    playerCharacter.PivotTo
    playerHrp.PivotTo
}

function newPlayer(player: Player): void {
    const t = Workspace.GetServerTimeNow();

    playingPlayers.push({
        player: player,
        score: 0,
    })

    player.SetAttribute("RoundPlayer", true);

    teleportToSpawnLocation(player);

    // bind player humanoid die event to teleport 

}

function hasPlayingPlayer(player: Player): number | undefined {
    const has = playingPlayers.findIndex(v => v.player === player);
    return has;
}

function removePlayer(player: Player): void {
    const idx = hasPlayingPlayer(player);
    if ( !idx ) return;
    playingPlayers.remove(idx);
}

function timeout(time: number): void {
    for (let i = time; i > 0; i -= 1) {
        Workspace.SetAttribute("TIMEGUI", i);
        task.wait(1);
    }
}

// game loop
while (true) {
    /*  
        1. 

            WHEN disconnect playerHumanoid die event
    */

    // timeout stopped loop
    timeout(TIMEOUT_TIME);

    // wait player_to_start player try
    if ( Players.GetChildren().size() - 1 < PLAYERS_TO_START ) {
        // fire to notify about this

        Workspace.SetAttribute("TIMEGUI", `need ${PLAYERS_TO_START} players, for game start.`);

        while (true) {
            task.wait(.5);
            if (Players.GetChildren()[1] !== undefined ) {
                break;
            }
        }
    };

    // play button react
    const joinConnection = Network.JoinToGameEvent.OnServerEvent.Connect((player) => {
        if ( !player.IsDescendantOf(Players) ) return;
        if ( !hasPlayingPlayer(player) ) return; 
        newPlayer(player);
    });

    // remote to create play button every playing player

    // round timer
    timeout(ROUND_TIME);

    // round end
    // clear up

}