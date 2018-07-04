import QtQuick 2.0
import VPlay 2.0
import "../scenes"

EntityBase {
    width: gameScene.gridSize*2
    height: gameScene.gridSize*2

    entityType: "projectile"


    property double x2
    property double y2
    property int imagenumber: 1
    MultiResolutionImage {
        id: monsterImage
        fillMode:Image.PreserveAspectCrop
        anchors.fill: parent
    }


    // 这些值可以在下面的MouseArea中创建新的弹丸时设置。
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
    Timer{
        id:projectiletime
        interval:60
        running:true
        repeat: true
        onTriggered: {
            console.debug("image:"+imagenumber)
            imagenumber+=1
            selectfireImage()
        }
    }



    BoxCollider {
        id: a
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
    }
    function selectfireImage(){
        if(imagenumber==4)
        {
            imagenumber=1
        }
        switch(imagenumber)
        {

        case 1:monsterImage.source="../../assets/player/action/fire/zidan2.png";break;

        case 2:monsterImage.source="../../assets/player/action/fire/zidan3.png";break;

        case 3:monsterImage.source="../../assets/player/action/fire/zidan4.png";break;


        }
    }
}
