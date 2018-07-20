import QtQuick 2.0
import VPlay 2.0
import "../sceneElements"
import "../../common"

SceneBase{
    id: menuScene

    signal entergamePressed
    signal servercomein
    signal clientcomein

    //背景
    Rectangle{
        id: background1
        anchors.fill:parent.gameWindowAnchorItem
        MultiResolutionImage{
            fillMode: Image.PreserveAspectFit
            source:"../../../assets/ui/menuB/2.JPEG"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            scale:0.5
        }
    }

    MultiResolutionImage{
        id:backgroundimage2
        fillMode: Image.PreserveAspectFit
        source: "../../../assets/ui/menuB/MenuB01.png"
        width: 350
        height: 180

        anchors.top: menuScene.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MultiResolutionImage{
        id: severstarter
        //fillMode: Image.PreserveAspectFit
        //source: "../../../assets/ui/menuB/1v2C.png"
        Text{
            text:"创建房间"
            anchors.fill: parent
        }

        width: 90
        height: 30

        anchors.top: backgroundimage2.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea{
            anchors.fill:  parent
			onClicked: {
                audioManager.playSound("option")
                entergamePressed()
                servercomein()

            }
        }
    }
    MultiResolutionImage{
        id: clienttarter
        fillMode: Image.PreserveAspectFit
       // source: "../../../assets/ui/menuB/1vcC.png"
        Text
        {
            text:"加入房间"
            anchors.fill: parent
        }

        width: 90
        height: 30

        anchors.top: severstarter.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea{
            anchors.fill:  parent
            onClicked: {
                audioManager.playSound("option")
                socket.sendState("joinRoom",true)
                entergamePressed()
                clientcomein()

            }
        }
    }

    MultiResolutionImage {
      id: musicButton
      source: "../../../assets/ui/menuB/voiceStop.png"
      // reduce opacity, if music is disabled
      opacity: settings.musicEnabled ? 0.9 : 0.4

      anchors.top: parent.top
      anchors.topMargin: 200
      anchors.left: parent.left
      anchors.leftMargin: 30
      width: 35
      height: 35

      MouseArea {
        anchors.fill: parent

        onClicked: {
          // switch between enabled and disabled
          if(settings.musicEnabled)
            settings.musicEnabled = false
          else
            settings.musicEnabled = true
        }
      }
    }

    MultiResolutionImage {
      id: soundButton
      source: settings.soundEnabled ? "../../assets/ui/sound_on.png" : "../../assets/ui/sound_off.png"
      opacity: settings.soundEnabled ? 0.9 : 0.4

      anchors.top: musicButton.bottom
      anchors.topMargin: 10
      anchors.left: parent.left
      anchors.leftMargin: 30

      MouseArea {
        anchors.fill: parent

        onClicked: {

          if(settings.soundEnabled) {
            settings.soundEnabled = false
          }
          else {
            settings.soundEnabled = true



          }
        }
      }
    }

    Text{
        anchors.left: parent.left
        anchors.top: parent.top
        text: "v1.0"
                color: "#E3E3E3"
   }


}
