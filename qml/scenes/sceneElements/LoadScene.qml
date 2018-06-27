import VPlay 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../common"

SceneBase {
    id: loadingscene

    signal signoutPressed
    signal togameScene

    property alias waittimer: waittime
    BusyIndicator {
        width: 54
        height: 56
        anchors.centerIn: parent
        running: Image.Loading
    }
    BusyIndicator {
        width: 60
        height: 62
        anchors.centerIn: parent
        running: Image.Loading
    }

    PlatformerImageButton{
        id: cancelButtom
        anchors.right: loadingscene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: loadingscene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        width: 30
        height: 30
        text:"Cancel"
        onClicked:{
            backButtonPressed()
            waittime.stop()
        }
    }

    Timer{
        id:waittime
        interval: 2000
        running: false
        repeat: true
        onTriggered: {
             togameScene()
        }
    }
}
