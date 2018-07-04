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
        source: "../../../assets/ui/menuB/1v2C.png"
        width: 90
        height: 30

        anchors.top: backgroundimage2.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea{
            anchors.fill:  parent
            onClicked: {
                socket.sendState("createRoom",true)
                entergamePressed()
                servercomein()
            }
        }
    }
    MultiResolutionImage{
        id: clienttarter
        fillMode: Image.PreserveAspectFit
        source: "../../../assets/ui/menuB/1vcC.png"
        width: 90
        height: 30

        anchors.top: severstarter.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea{
            anchors.fill:  parent
            onClicked: {
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
      source: settings.soundEnabled ? "../../assets/ui   `/sound_on.png" : "../../assets/ui/sound_off.png"
      opacity: settings.soundEnabled ? 0.9 : 0.4

      anchors.top: musicButton.bottom
      anchors.topMargin: 10
      anchors.left: parent.left
      anchors.leftMargin: 30

      MouseArea {
        anchors.fill: parent

        onClicked: {
          // switch between enabled and disabled
          if(settings.soundEnabled) {
            settings.soundEnabled = false
          }
          else {
            settings.soundEnabled = true

            // play sound to signal, that sound is now on
            audioManager.playSound("playerJump")
          }
        }
      }
    }

    Text{
        anchors.left: parent.left
        anchors.top: parent.top
        text: "v0.8"
                color: "#E3E3E3"
   }


}
