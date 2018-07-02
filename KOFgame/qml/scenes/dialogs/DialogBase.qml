import QtQuick 2.0
import VPlay 2.0


Item {
    id: dialogBase

    z:1000

    anchors.fill: parent.gameWindowAnchorItem ? parent.gameWindowAnchorItem : parent

    opacity: 0
    enabled: opacity > 0

    property bool closeableByClickOnBackground: true

//    MouseArea{
//        anchors.fill: parent

////        onClicked: {
////            if(closeableByClickOnBackground)

////        }
//    }

}
