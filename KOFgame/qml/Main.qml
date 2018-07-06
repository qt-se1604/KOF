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
    property int settime:0
    property int setmusic: 0
    property int setbackground:0


    onActiveSceneChanged:{
        audioManager.handleMusic()
    }

    UdpSocket {
        id: socket
        url: "10.253.197.51:10000"

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
        onTimeChanged: {
            settime  = time
        }
        onMusicChanged: {
            setmusic = music
        }
        onBackgroundChanged: {
            setbackground = background
        }
		onFindgameChanged: {
			console.log("findgame")
			if(findgame)
				loadingScene.togameScene()
		}

    }

    onStateChanged: {
        gameScene.timeeetotal.stop()
        if(gameWindow.state === "loading")
            loadingScene.waittimer.running = true
        else
            loadingScene.waittimer.running = false
        if(gameWindow.state === "game") {
            gameScene.timeeetotal.restart()
            gameScene.timeereduce.restart()
            gameScene.totaltime = settime
        }
		finishScene.againButton.enabled = true
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
            gameWindow.state =  "set"
        }
        onClientcomein: {
            gameWindow.playeridentity = 2
            gameWindow.state = "loading"
        }
//        onEntergamePressed:{
//            gameWindow.state = "loading"
//        }
    }

    SetScene{
        id:setScene
        onStartgamenow: {
            gameWindow.state =  "loading"
        }
        onTime60: {
            settime = 60
        }
        onTime8: {
            settime  = 90
        }
        onMusic1: {
            setmusic = 1
        }
        onMusic2: {
            setmusic = 2
        }
        onBackground1: {
            setbackground = 1
        }
        onBackground2: {
            setbackground = 2
        }
    }

    LoadScene{
        id:loadingScene
        waittimer {
            running:false
        }
        onBackButtonPressed: gameWindow.state = "menu"
        onTogameScene: {
			if(gameWindow.state !== "menu") {
                gameWindow.state = "game"
			}
        }

	}

    GameScene{
        id: gameScene
        playerID:gameWindow.playeridentity
        gametime: settime
        gamemusic: setmusic
        gamebackground: setbackground
        onToGameOver: gameWindow.state = "finish"
    }
    FinishScene{
            id:finishScene
            onTogamepress: gameWindow.state="game"
            onBackButtonPressed: gameWindow.state="menu"
    }

    Component.onCompleted: {
        socket.sendState("login",true)
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
            name: "set"
            PropertyChanges { target: setScene;opacity :1}
            PropertyChanges {target: gameWindow;activeScene:setScene}
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
            PropertyChanges {target: gameWindow;activeScene:finishScene}
        }
    ]
}
