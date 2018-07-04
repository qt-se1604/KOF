import QtQuick 2.0
import VPlay 2.0
import "../sceneElements"
import "../../common"

SceneBase{
    id:setScene

    signal startgamenow
    property int timebuttom:0
    property int musicbuttom:0
    property int backgroundbuttom:0

    MultiResolutionImage{
        id: gamestartimage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top :parent.top
        anchors.topMargin: parent.height/10
        width: parent.width/5
        height: parent.height/5
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill:parent
            onClicked: {
                startgamenow()
            }
        }
    }

    MultiResolutionImage{
        id: gametimeimage
        anchors.top :gamestartimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/3
        width: parent.width/12
        height: parent.height/15
        source: "../../../assets/ui/menuB/MenuB01.png"
    }
    MultiResolutionImage{
        id: gamemusicimage

        anchors.top :gametimeimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/3
        width: parent.width/12
        height: parent.height/15
        source: "../../../assets/ui/menuB/MenuB01.png"
    }
    MultiResolutionImage{
        id: gamebackground
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top :parent.top
        anchors.topMargin: parent.height/10
        width: parent.width/5
        height: parent.height/5
        source: "../../../assets/ui/menuB/MenuB01.png"
    }


//time buttom
    MultiResolutionImage{
        id: timechoose1
        anchors.top :gamestartimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: gametimeimage.right
        anchors.leftMargin: parent.width/15
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                timebuttom = timebuttom-1
                if(timebuttom<0)
                    timebuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showtime
        anchors.top :gamestartimage.bottom
        anchors.topMargin: parent.height/15
        anchors.left: timechoose1.right
        anchors.leftMargin: parent.width/20
        width: parent.width/20
        height: parent.height/20
        source: timebuttom>0? "图二" : "图一 "
    }



    MultiResolutionImage{
        id: timechoose2
        anchors.top :gamestartimage.bottom
        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                timebuttom = timebuttom++
                timebuttom = timebuttom%2
            }
        }
    }


//music buttom
    MultiResolutionImage{
        id: musicchoose1
        anchors.top :timechoose1.bottom
        anchors.topMargin: parent.height/15
        anchors.left: gamemusicimage.right
        anchors.leftMargin: parent.width/15
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                musicbuttom = musicbuttom-1
                if(musicbuttom<0)
                    musicbuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showmusic
        anchors.top :timechoose1.bottom
        anchors.topMargin: parent.height/15
        anchors.left: musicchoose1.right
        anchors.leftMargin: parent.width/20
        width: parent.width/20
        height: parent.height/20
        source: musicbuttom > 0? "图二" : "图一 "
    }


    MultiResolutionImage{
        id: musicchoose2
        anchors.top :timechoose2.bottom
        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                timebuttom = timebuttom++
                timebuttom = timebuttom%2
            }
        }
    }


//background
    MultiResolutionImage{
        id: backgroundchoose1
        anchors.top :musicchoose1.bottom
        anchors.topMargin: parent.height/15
        anchors.left: gamebackground.right
        anchors.leftMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                backgroundbuttom = backgroundbuttom-1
                if(backgroundbuttom<0)
                    backgroundbuttom = 1
            }
        }
    }

    MultiResolutionImage{
        id: showbackground
        anchors.top :musicchoose1.bottom
        anchors.topMargin: parent.height/15
        anchors.left: backgroundchoose1.right
        anchors.leftMargin: parent.width/20
        width: parent.width/20
        height: parent.height/20
        source: backgroundbuttom > 0? "图二" : "图一 "
    }

    MultiResolutionImage{
        id: backgroundchoose2
        anchors.top :musicchoose2.bottom
        anchors.topMargin: parent.height/15
        anchors.right: parent.right
        anchors.rightMargin: parent.width/4
        width: parent.width/20
        height: parent.height/20
        source: "../../../assets/ui/menuB/MenuB01.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                backgroundbuttom = backgroundbuttom++
                backgroundbuttom = backgroundbuttom%2
            }
        }
    }





}
