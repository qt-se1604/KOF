import VPlay 2.0
import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../common"
SceneBase {
    id: settlementscene

    property double gamescore
    signal togamepress
    BusyIndicator {
        width: 100
        height: 100
        anchors.centerIn: parent
        running: Image.Loading
    }
    Text{
        id: scoreshow
        anchors.centerIn: parent
        text:"Score:" + gamescore
    }
    PlatformerImageButton{
        width: 60
        height: 40
        anchors.right: settlementscene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: settlementscene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        text:"Back Menu"
        onClicked:backButtonPressed()
    }

    PlatformerImageButton{
        width: 60
        height: 40
        anchors.left:  settlementscene.gameWindowAnchorItem.left
        anchors.rightMargin: 10
        anchors.top: settlementscene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        text:"Again"
        onClicked:togamepress()
    }
}
