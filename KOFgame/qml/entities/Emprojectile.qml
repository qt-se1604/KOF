import QtQuick 2.0
import VPlay 2.0
import "../scenes"

EntityBase {
    width: gameScene.gridSize / 2
    height: gameScene.gridSize / 2

    entityType: "Enemyprojectile"

    property double x2
    property double y2

    property point destination
    property int moveDuration

    PropertyAnimation on x {
        from: x2
        to: destination.x
        duration: moveDuration //移动持续时间
    }

    PropertyAnimation on y {
        from: y2
        to: destination.y
        duration: moveDuration
    }

    BoxCollider {
        id: a
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: parent.width
        collisionTestingOnlyMode: true
    }
}
