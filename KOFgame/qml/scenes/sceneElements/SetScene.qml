import QtQuick 2.0
import VPlay 2.0
import "../sceneElements"
import "../../common"

SceneBase{
    id:setScene

    signal startgamenow
    signal time60
    signal time8
    signal music1
    signal music2
    signal background1
    signal background2

    property int timebuttom:0
    property int musicbuttom:0
    property int backgroundbuttom:0
    Rectangle{
        anchors.fill: parent
        color:"white"
    }

    Image {
 anchors.fill: parent
        source: "../../../assets/ui/setting.png"
    }
    MultiResolutionImage{
        id: gamestartimage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top :parent.top
        anchors.topMargin: parent.height/10
        width: parent.width/6
        height: parent.height/6
        source: "../../../assets/ui/shezhi.png"
        MouseArea{
            anchors.fill:parent
			onClicked: {
                 audioManager.playSound("option")

                if(timebuttom===0){
                    time60()
                    socket.sendState("time", 60)
                }
                else{
                    time8()
                    socket.sendState("time", 90)
                }

                if(musicbuttom===0){
                    music1()
                    socket.sendState("music", 1)
                }
                else{
                    music2()
                    socket.sendState("music", 2)
                }

				if(backgroundbuttom === 0) {
                    background1()
					socket.sendState("background", 1)
                }
				else {
                    background2()
					socket.sendState("background", 2)
                }

				socket.sendState("createRoom",true)
                startgamenow()
            }
        }
    }

    MultiResolutionImage{
        id: gametimeimage
        anchors.top :gamestartimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/4
        width: parent.width/12
        height: parent.height/15
//        source: "../../../assets/ui/menuB/MenuB01.png"
        Text{
            text:"时间："
            color: "black"
        }
    }
    MultiResolutionImage{
        id: gamemusicimage

        anchors.top :gametimeimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/4
        width: parent.width/12
        height: parent.height/15
//        source: "../../../assets/ui/menuB/MenuB01.png"
        Text{
            text:"音乐："
            color:"black"
        }
    }
    MultiResolutionImage{
        id: gamebackground
        anchors.top :gamemusicimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/4
        width: parent.width/12
        height: parent.height/15
//        source: "../../../assets/ui/menuB/MenuB01.png"
        Text{
            text:"地图："
            anchors.fill:parent
            color: "black"
        }
    }


//time buttom
    MultiResolutionImage{
        id: timechoose1
        anchors.top :gametimeimage.top
//        anchors.topMargin: parent.height/15
        anchors.left: gametimeimage.right
        anchors.leftMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/right.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                timebuttom = timebuttom-1
                if(timebuttom<0)
                    timebuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showtime
        anchors.top :gametimeimage.top
//        anchors.topMargin: parent.height/15
        anchors.left: timechoose1.right
        anchors.leftMargin: parent.width/25
        width: parent.width/20
        height: parent.height/20
//        source: timebuttom>0? "../../../assets/ui/menuB/MenuB01.png" : "../../../assets/ui/menuB/1v2C.png"
        Text{
            text:timebuttom>0? "60":"90"
            color: "black"
        }
    }



    MultiResolutionImage{
        id: timechoose2
        anchors.top :gametimeimage.top
//        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/5
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/left.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                timebuttom = timebuttom+1
                timebuttom = timebuttom%2
            }
        }
    }


//music buttom
    MultiResolutionImage{
        id: musicchoose1
        anchors.top :gamemusicimage.top
//        anchors.topMargin: parent.height/15
        anchors.left: gamemusicimage.right
        anchors.leftMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/right.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                musicbuttom = musicbuttom-1
                if(musicbuttom<0)
                    musicbuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showmusic
        anchors.top :gamemusicimage.top
//        anchors.topMargin: parent.height/15
        anchors.left: musicchoose1.right
        anchors.leftMargin: parent.width/20
        width: parent.width/20
        height: parent.height/20
//        source: musicbuttom > 0? "../../../assets/ui/menuB/MenuB01.png" : "../../../assets/ui/menuB/1v2C.png"
        Text{
            text:musicbuttom > 0?"1":"2"
            color: "black"
        }
    }


    MultiResolutionImage{
        id: musicchoose2
        anchors.top :gamemusicimage.top
//        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/5
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/left.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                musicbuttom = musicbuttom+1
                musicbuttom = musicbuttom%2
            }
        }
    }


//background
    MultiResolutionImage{
        id: backgroundchoose1
        anchors.top :gamebackground.top
//        anchors.topMargin: parent.height/15
        anchors.left: gamebackground.right
        anchors.leftMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/right.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                backgroundbuttom = backgroundbuttom-1
                if(backgroundbuttom<0)
                    backgroundbuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showbackground
        anchors.top :gamebackground.top
//        anchors.topMargin: parent.height/15
        anchors.left: backgroundchoose1.right
        anchors.leftMargin: parent.width/20
        width: parent.width/20
        height: parent.height/20
//        source: backgroundbuttom > 0? "../../../assets/ui/menuB/MenuB01.png" : "../../../assets/ui/menuB/1v2C.png"
        Text{
            text:backgroundbuttom > 0?"1":"2"
            color: "black"
        }
    }

    MultiResolutionImage{
        id: backgroundchoose2
        anchors.top :gamebackground.top
//        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/5
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/anniu/left.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                 audioManager.playSound("option")
                backgroundbuttom = backgroundbuttom+1
                backgroundbuttom = backgroundbuttom%2
            }
        }
    }

}
