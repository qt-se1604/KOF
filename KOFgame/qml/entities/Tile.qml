import QtQuick 2.0
import VPlay 2.0

Item {
    width: gameScene.gridSize
    height: gameScene.gridSize
    property alias image: sprite.source
    property string pos :"mid"

    MultiResolutionImage{
        id:sprite
        anchors.left: pos == "right" ?parent.left:undefined
        anchors.right:pos == "left"?parent.right:undefined
    }
}
