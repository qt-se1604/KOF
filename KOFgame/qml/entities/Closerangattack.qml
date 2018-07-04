import QtQuick 2.0
import VPlay 2.0
import "../scenes"

EntityBase {
    width: gameScene.gridSize*2.5
    height: gameScene.gridSize



    signal attackfinish()

    entityType: "closerangattack"
//    entityId: "closeattack1"

    property double x2
    property double y2

//    MultiResolutionImage {
//        id: monsterImage

//        source: "../../assets/img/Projectile.png"
//    }


    // 这些值可以在下面的MouseArea中创建新的弹丸时设置。
//    property point destination
//    property int moveDuration

//    PropertyAnimation on x {
//        from: x2
//        to: destination.x
//        duration: moveDuration //移动持续时间
//    }

//    PropertyAnimation on y {
//        from: y2
//        to: destination.y
//        duration: moveDuration
//    }


    BoxCollider {
        id: a
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true

    }

    Timer{
        id:closerangattacking
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            removeEntity()
//            attackfinish()
        }
    }

}
