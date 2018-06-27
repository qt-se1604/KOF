import QtQuick 2.0
import VPlay 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../common"
import "../../entities"
import "../dialogs"

SceneBase{
    id: gameScene

    signal toGameOver()
    signal scoreChanged()
    property double gamescore: 100

    sceneAlignmentX: "left"
    sceneAlignmentY: "right"

    gridSize: 32

//    //玩家游戏进程的时间计时
//    property int time:0




    OperationInterface {
            anchors.fill: parent
            onControllerPositionChanged: {
                console.log(controllerDirection)
            }
            onAttackPressed: {
                console.log("attach pressed: " + isAttack)
            }
            onJumpPressed: {
                console.log("Jump pressed: " + isJump)
            }
            onUnsetPressed: {
                console.log("unset pressed: " + isUnset);
            }
            PlatformerImageButton{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 80
                height: 50
                color: "yellow"
                text:"OVER"
                onClicked:
                {
                    finishScene.gamescore=gameScene.gamescore
                    toGameOver()
                }
            }
        }
}








