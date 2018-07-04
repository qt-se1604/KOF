import VPlay 2.0
import QtQuick 2.0
import "scenes/sceneElements"
import "common"
import my.socket 1.0

GameWindow {
	id: gameWindow

    activeScene: menuScene

	screenWidth: 960
	screenHeight: 640

    property int playeridentity:0

    onActiveSceneChanged:{
        audioManager.handleMusic()
    }

    UdpSocket {
        id: socket
        url: "127.0.0.1:10000"

        onXChanged: {
            gameScene.enemyplayer.x = xValue
        }
        onYChanged: {
            gameScene.enemyplayer.y = yValue
        }
        onStateChanged: {
            console.log(currentState)
            switch(currentState) {
                case UdpSocket.Unconnected:
                    console.log("Unconnected")
                    break
                case UdpSocket.Connected:
                    console.log("Connected")
                    break
                case UdpSocket.Other:
                    console.log("Other")
                    break
            }
        }
		Component.onCompleted: {
			sendState("login", true)
		}
    }

    onStateChanged: {
        if(gameWindow.state === "loading")
            loadingScene.waittimer.running = true
        else
            loadingScene.waittimer.running = false
    }

    AudioManager{
        id: audioManager
    }

    EntityManager {
      id: entityManager

      // here we define the container the entityManager manages
      // so all entities, the entityManager creates are in this container
      entityContainer: gameScene.container

      poolingEnabled: true
    }

    MenuScene{
        id: menuScene
        onServercomein: {
            gameWindow.playeridentity = 1
        }
        onClientcomein: {
            gameWindow.playeridentity = 2
        }
        onEntergamePressed:{
            console.debug("3232")
            gameWindow.state = "loading"
        }
    }

    LoadScene{
        id:loadingScene
        waittimer {
            running:false
        }
        onBackButtonPressed: gameWindow.state = "menu"
        onTogameScene: {
            console.debug("21211")
            if(gameWindow.state !== "menu")
                gameWindow.state = "game"

        }

    }
    GameScene{
        id: gameScene
        playerID:gameWindow.playeridentity
        onToGameOver: gameWindow.state = "finish"
    }
    FinishScene{
            id:finishScene
            onTogamepress: gameWindow.state="game"
            onBackButtonPressed: gameWindow.state="menu"
    }




    // states
    state: "menu"

    // this state machine handles the transition between scenes
    states: [
        State {
            name: "menu"
            PropertyChanges { target: menuScene;opacity :1}
            PropertyChanges {target: gameWindow;activeScene:menuScene}
        },
        State {
            name: "loading"
            PropertyChanges { target: loadingScene;opacity :1}
            PropertyChanges {target: gameWindow;activeScene:loadingScene}
        },
        State {
            name: "game"
            PropertyChanges { target: gameScene;opacity :1}
            PropertyChanges {target: gameWindow;activeScene:gameScene}
        },
        State {
            name: "finish"
            PropertyChanges { target: finishScene;opacity :1}
            PropertyChanges {target: gameWindow;activeScene:finshScene}
        }
    ]
}
