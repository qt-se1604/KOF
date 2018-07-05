import QtQuick 2.0
import "../scenes/sceneElements"

Item{
    property alias enemyblood:enemyblood
    property alias bloodvolume1: bloodvolume1
    property alias bloodvolume2: bloodvolume2
    Row{

        Image {
            height:20
            width: 20
            source: "../../assets/blood/touxiang1.png"
        }

        Rectangle{
            id:bloodvolume1
            y:5
            height: 5
            color: "#0038ff"
            Image {
                anchors.fill:parent
                source: "../../assets/blood/blood.png"
            }
        }


    }
    Row{
        id:enemyblood
        x:parent.x+350
        Rectangle{
            id:bloodvolume2
            y:5
            height: 5
            color: "black"
            Image {

                  anchors.fill:parent
                source: "../../assets/blood/blood.png"
            }

        }
        Image {
            height:20
            width: 20
            source: "../../assets/blood/touxiang2.png"
        }

    }
}
