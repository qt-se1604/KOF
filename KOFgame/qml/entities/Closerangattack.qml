import QtQuick 2.0
import VPlay 2.0
import "../scenes"

EntityBase {
    width: gameScene.gridSize*6
    height: gameScene.gridSize*9




    signal attackfinish()

    entityType: "closerangattack"
//    entityId: "closeattack1"

    property double x2
    property double y2

    MultiResolutionImage {
        id:dazhao
        anchors.fill: a
    }


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
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
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
    property int imagenumber:1
    Timer{
        id:datimer
        interval: 110
        repeat: true
        running: true
        onTriggered: {
            imagenumber+=1
            seletimage()

        }
    }
    function seletimage()
    {
        if(imagenumber==18)
        {
            imagenumber=1
        }
        switch(imagenumber)
        {

        case 1:dazhao.source="../../assets/player/action/dazhao/1.png";break;

        case 2:dazhao.source="../../assets/player/action/dazhao/2.png";break;

        case 3:dazhao.source="../../assets/player/action/dazhao/3.png";break;

        case 4:dazhao.source="../../assets/player/action/dazhao/4.png";break;

        case 5:dazhao.source="../../assets/player/action/dazhao/5.png";break;
        case 6:dazhao.source="../../assets/player/action/dazhao/6.png";break;

        case 7:dazhao.source="../../assets/player/action/dazhao/7.png";break;

        case 8:dazhao.source="../../assets/player/action/dazhao/8.png";break;

        case 9:dazhao.source="../../assets/player/action/dazhao/9.png";break;

        case 10:dazhao.source="../../assets/player/action/dazhao/10.png";break;
        case 11:dazhao.source="../../assets/player/action/dazhao/11.png";break;

        case 12:dazhao.source="../../assets/player/action/dazhao/12.png";break;

        case 13:dazhao.source="../../assets/player/action/dazhao/13.png";break;

        case 14:dazhao.source="../../assets/player/action/dazhao/14.png";break;

        case 15:dazhao.source="../../assets/player/action/dazhao/15.png";break;
        case 16:dazhao.source="../../assets/player/action/dazhao/16.png";break;

        case 17:dazhao.source="../../assets/player/action/dazhao/17.png";break;


        default:break;
        }
    }
}
