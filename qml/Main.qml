import VPlay 2.0
import QtQuick 2.0
import "scenes/sceneElements"
import "common"

GameWindow {
	id: gameWindow

    activeScene: menuScene

	screenWidth: 960
	screenHeight: 640

    onActiveSceneChanged:{
        AudioManager.handleMusic()
        if(activeScene === gameScene)
            console.debug("222")
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
