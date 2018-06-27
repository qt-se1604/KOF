import QtQuick 2.0
import VPlay 2.0
import "../sceneElements"
import "../../common"

SceneBase{
    id: menuScene

    signal entergamePressed

    //背景
    Rectangle{
        id: background

        anchors.fill:parent.gameWindowAnchorItem

        gradient: Gradient{
            GradientStop { position: 0.0;color: "#4595e6"}
            GradientStop { position: 0.9;color: "#80bfff"}
            GradientStop { position: 0.95;color: "#009900"}
            GradientStop { position: 1.0;color: "#804c00" }
        }
    }

    //header
    Rectangle{
        id: header

        height: 95

        anchors.top : menuScene.gameWindowAnchorItem.top
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.margins: 5

        //背景颜色
        color: "#cce6ff"

        radius: height/4

        //header图片
        MultiResolutionImage{
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 10

            source: "../../assets/ui/header.png"
        }
        Text{
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            text: "Welcome to King of fighter \n Please select an option"
            font.pixelSize:  20
            elide: Text.ElideMiddle
            color: "#363636"
        }
    }

    Rectangle{
        id: startServer
        anchors.centerIn: parent
        width: parent.width/2
        height:  parent.height/5
        color: "#363636"

        Text{
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            font.bold: true
            text: "start King of fighter server"
            color: "#E3E3E3"
            wrapMode: Text.WordWrap
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                //转换对战页面
                console.debug("1")
                entergamePressed()
            }
        }
//        PlatformerImageButton {
//          id: menuButton1

//          width: 40
//          height: 30

//          anchors.centerIn: startServer

//          image.source: "../../assets/ui/home.png"

//          // this button should only be visible in play or edit mode
//          visible: gameScene.state == "enum"

//          // go back to menu
//          onClicked: {
//              entergamePressed()
//              console.debug("1")
//          }
//        }
    }

    Rectangle{
        id: startClient
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: startServer.bottom
        anchors.topMargin: 10
        width:  parent.width/2
        height:  parent.height/5
        color: "#363636"

        Text{
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            font.bold: true
            text: "start King of fighter Client"
            color: "#E3E3E3"
            wrapMode: Text.WordWrap
        }

//        MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                console.debug("2")
//                entergamePressed()
//                //转换对战页面
//            }
//        }

        PlatformerImageButton {
          id: menuButton2

          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
          width:  parent.width
          height:  parent.height

          focus: true
          anchors.fill: parent

          image.source: "../../assets/ui/home.png"

          // this button should only be visible in play or edit mode
          //visible: gameScene.state === "menu"

          // go back to menu
          onClicked: {entergamePressed()
              console.debug("2")
          }
        }
    }
}
