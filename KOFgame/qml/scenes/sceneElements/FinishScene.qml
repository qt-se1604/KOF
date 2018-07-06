import VPlay 2.0
import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../common"
SceneBase {
    id: settlementscene

    property bool gameWon
    signal togamepress
	property alias againButton : againButton

	MultiResolutionImage {
		anchors.fill: parent
        source: "../../../assets/ui/finish1.png"
	}

    Text{
        id: scoreshow
        anchors.centerIn: parent
        text: gameWon ? "You won :)" : "You lost"
        color: "white"
    }
    PlatformerImageButton{
        width: 60
        height: 40
        anchors.right: settlementscene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: settlementscene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        text:"Back Menu"
        onClicked:{
            gameScene.viewPort.player.blood=100
            gameScene.viewPort.enemy.blood=100

            backButtonPressed()
			socket.sendState("quitRoom", true)
        }
    }
	Connections {
		target: socket
		onQuitRoomChanged: {
			if(isQuitRoom) {
				gameScene.viewPort.player.blood=100
				gameScene.viewPort.enemy.blood=100

				againButton.enabled = false
			}
		}
	}

    PlatformerImageButton{
		id: againButton
        width: 60
        height: 40
        anchors.left:  settlementscene.gameWindowAnchorItem.left
        anchors.rightMargin: 10
        anchors.top: settlementscene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        text:"Again"
        onClicked:
        {
            togamepress()
            gameScene.viewPort.player.blood=100
            gameScene.viewPort.enemy.blood=100
            gameScene.viewPort.gametruetime.timeeetotal.restart()
            gameScene.viewPort.gametruetime.totaltime = gameScene.viewPort.gametruetime.timeeetotal.interval/1000

        }
    }
}
