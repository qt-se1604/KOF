import QtQuick 2.0
import VPlay 2.0
import "../scenes"

EntityBase {
	width: gameScene.gridSize*1.5
	height: gameScene.gridSize*1.5

    entityType: "Enemyprojectile"

    property double x2
    property double y2
    property int imagenumber: 1
    property point destination
    property int moveDuration
property bool face:true
    MultiResolutionImage {
        id: monsterImage
        fillMode:Image.PreserveAspectCrop
        anchors.fill: parent
    }
    PropertyAnimation on x {
        from: x2
        to: x2+destination.x
        duration: 3000 //移动持续时间
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
            if(player.x - enemy.x>0)
            {
                face=true
            }
            else{
                face=false
            }

            imagenumber+=1
            selectfireImage()
        }
    }

    Timer{
        id: deleteentity
        running: true
        repeat: false
        interval: 3000
        onTriggered: {
            removeEntity()
        }
    }


    BoxCollider {
        id: a
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: parent.width
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
    }
    function selectfireImage(){
        if(face)
        {
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
        }else
        {
            if(imagenumber==4)
            {
                imagenumber=1
            }
            switch(imagenumber)
            {

            case 1:monsterImage.source="../../assets/player/action/fire/zidan12.png";break;

            case 2:monsterImage.source="../../assets/player/action/fire/zidan13.png";break;

            case 3:monsterImage.source="../../assets/player/action/fire/zidan14.png";break;


            }
        }

    }
}
