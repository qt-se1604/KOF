import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: enemy
    entityType: "enemy"
    width: 2.5 * gameScene.gridSize
    height: 3.5 * gameScene.gridSize
    property int enemyaction: 0
    property bool  enemyface: true
    property bool actionend:true
    MultiResolutionImage {
        id:playerImage
        anchors.fill:collider
    }
    property double blood: 100
    property int  imagenumber: 1
    BoxCollider {
        id: collider
        height: parent.height
        width: parent.width * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        bodyType: Body.Dynamic
        fixedRotation: true
        sleepingAllowed: false
        density: 10
        gravityScale: 0
        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            if (collidedEntity.entityType === "projectile") {
                enemyaction = 6
                imagenumber=1
                if(blood>0)
                {
                    blood-=10
                }
                collidedEntity.removeEntity()
            }
        }
    }
    Timer{
        id:enemyactiontime
        interval:90
        running:true
        repeat: true
        onTriggered: {
//            console.debug("image:"+imagenumber)
            imagenumber+=1
            if(player.x - enemy.x>0)
            {
                enemyface=true
            }
            else{
                enemyface=false
            }
            selectImage()


        }
    }
    function selectImage(){
        if(enemyface){
            if(enemyaction==0)
            {
                if(imagenumber==11)
                {
                    imagenumber=1
                }
                switch(imagenumber)
                {

                case 1:playerImage.source="../../assets/player/cao1.png";break;

                case 2:playerImage.source="../../assets/player/cao2.png";break;

                case 3:playerImage.source="../../assets/player/cao3.png";break;

                case 4:playerImage.source="../../assets/player/cao4.png";break;

                case 5:playerImage.source="../../assets/player/cao5.png";break;
                case 6:playerImage.source="../../assets/player/cao6.png";break;

                case 7:playerImage.source="../../assets/player/cao7.png";break;

                case 8:playerImage.source="../../assets/player/cao8.png";break;

                case 9:playerImage.source="../../assets/player/cao9.png";break;

                case 10:playerImage.source="../../assets/player/cao10.png";break;

                default:break;
                }
            }
            if(enemyaction==1){
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                }
                switch(imagenumber)
                {

                case 1:playerImage.source="../../assets/player/action/zou2.png";break;

                case 2:playerImage.source="../../assets/player/action/zou3.png";break;

                case 3:playerImage.source="../../assets/player/action/zou4.png";break;

                case 4:playerImage.source="../../assets/player/action/zou5.png";break;

                case 5:playerImage.source="../../assets/player/action/zou6.png";break;
                    default:break;
                }
            }
            if(enemyaction==2){
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                }
                switch(imagenumber)
                {

                case 5:playerImage.source="../../assets/player/action/zou2.png";break;

                case 4:playerImage.source="../../assets/player/action/zou3.png";break;

                case 3:playerImage.source="../../assets/player/action/zou4.png";break;

                case 2:playerImage.source="../../assets/player/action/zou5.png";break;

                case 1:playerImage.source="../../assets/player/action/zou6.png";break;
                    default:break;
                }
            }
            if(enemyaction==3){
                enemyactiontime.interval
                =120
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true
                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/fire/fire1.png";break;
                case 2:playerImage.source="../../assets/player/action/fire/fire2.png";break;
                case 3:playerImage.source="../../assets/player/action/fire/fire3.png";break;
                case 4:playerImage.source="../../assets/player/action/fire/fire4.png";break;
                case 5:playerImage.source="../../assets/player/action/fire/fire5.png";break;
                    default:break;
                }
            }
            if(enemyaction==4){
                enemyactiontime.interval
                =130
                if(imagenumber==8)
                {
                    imagenumber=1
                    enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true
                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/jump/jump2.png";break;
                case 2:playerImage.source="../../assets/player/action/jump/jump2.png";break;
                case 3:playerImage.source="../../assets/player/action/jump/jump3.png";break;
                case 4:playerImage.source="../../assets/player/action/jump/jump4.png";break;
                case 5:playerImage.source="../../assets/player/action/jump/jump5.png";break;
                case 6:playerImage.source="../../assets/player/action/jump/jump6.png";break;
                case 7:playerImage.source="../../assets/player/action/jump/jump7.png";break;
                    default:break;
//                case 8:playerImage.source="../../assets/player/action/jump/jump.png";break;
//                case 9:playerImage.source="../../assets/player/action/jump/jump9.png";break;
                }
            }
            if(enemyaction==5){
                enemyactiontime.interval
                =100
                if(imagenumber==9)
                {
                    imagenumber=1
                   enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true
                    closewy.stop()
                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/closeattic/close1.png";break;
                case 2:playerImage.source="../../assets/player/action/closeattic/close2.png";break;
                case 3:playerImage.source="../../assets/player/action/closeattic/close3.png";break;
                case 4:playerImage.source="../../assets/player/action/closeattic/close4.png";break;
                case 5:playerImage.source="../../assets/player/action/closeattic/close5.png";break;
                case 6:playerImage.source="../../assets/player/action/closeattic/close6.png";break;
                case 7:playerImage.source="../../assets/player/action/closeattic/close7.png";break;
                case 8:playerImage.source="../../assets/player/action/closeattic/close8.png";break;
default:break;
                }
            }
            if(enemyaction==6){
                enemyactiontime.interval
                        =100
                if(imagenumber==5)
                {
                    imagenumber=1
                    enemyaction=0
                   enemyactiontime.interval=90


                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/houtui/1.png";break;
                case 2:playerImage.source="../../assets/player/action/houtui/2.png";break;
                case 3:playerImage.source="../../assets/player/action/houtui/3.png";break;
                case 4:playerImage.source="../../assets/player/action/houtui/4.png";break;
                default:break;
                }
            }

        }else{
            if(enemyaction==0)
            {
                if(imagenumber==11)
                {
                    imagenumber=1
                }
                switch(imagenumber)
                {

                case 1:playerImage.source="../../assets/player/cao11.png";break;

                case 2:playerImage.source="../../assets/player/cao12.png";break;

                case 3:playerImage.source="../../assets/player/cao13.png";break;

                case 4:playerImage.source="../../assets/player/cao14.png";break;

                case 5:playerImage.source="../../assets/player/cao15.png";break;
                case 6:playerImage.source="../../assets/player/cao16.png";break;

                case 7:playerImage.source="../../assets/player/cao17.png";break;

                case 8:playerImage.source="../../assets/player/cao18.png";break;

                case 9:playerImage.source="../../assets/player/cao19.png";break;

                case 10:playerImage.source="../../assets/player/cao20.png";break;

                default:break;
                }
            }
            if(enemyaction==1){
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                }
                switch(imagenumber)
                {

                case 1:playerImage.source="../../assets/player/action/zou12.png";break;

                case 2:playerImage.source="../../assets/player/action/zou13.png";break;

                case 3:playerImage.source="../../assets/player/action/zou14.png";break;

                case 4:playerImage.source="../../assets/player/action/zou15.png";break;

                case 5:playerImage.source="../../assets/player/action/zou16.png";break;
                    default:break;
                }
            }
            if(enemyaction==2){
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                }
                switch(imagenumber)
                {

                case 5:playerImage.source="../../assets/player/action/zou12.png";break;

                case 4:playerImage.source="../../assets/player/action/zou13.png";break;

                case 3:playerImage.source="../../assets/player/action/zou14.png";break;

                case 2:playerImage.source="../../assets/player/action/zou15.png";break;

                case 1:playerImage.source="../../assets/player/action/zou16.png";break;
                    default:break;
                }
            }
            if(enemyaction==3){
                enemyactiontime.interval
                =120
                if(imagenumber==6)
                {
                    imagenumber=1
                    enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true
                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/fire/fire12.png";break;
                case 2:playerImage.source="../../assets/player/action/fire/fire13.png";break;
                case 3:playerImage.source="../../assets/player/action/fire/fire14.png";break;
                case 4:playerImage.source="../../assets/player/action/fire/fire15.png";break;
                case 5:playerImage.source="../../assets/player/action/fire/fire16.png";break;
                    default:break;
                }
            }
            if(enemyaction==4){
                enemyactiontime.interval
                =130
                if(imagenumber==8)
                {
                    imagenumber=1
                    enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true
                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/jump/jump12.png";break;
                case 2:playerImage.source="../../assets/player/action/jump/jump12.png";break;
                case 3:playerImage.source="../../assets/player/action/jump/jump13.png";break;
                case 4:playerImage.source="../../assets/player/action/jump/jump14.png";break;
                case 5:playerImage.source="../../assets/player/action/jump/jump15.png";break;
                case 6:playerImage.source="../../assets/player/action/jump/jump14.png";break;
                case 7:playerImage.source="../../assets/player/action/jump/jump13.png";break;
                    default:break;
//                case 8:playerImage.source="../../assets/player/action/jump/jump.png";break;
//                case 9:playerImage.source="../../assets/player/action/jump/jump9.png";break;
                }
            }
            if(enemyaction==5){
                enemyactiontime.interval
                =100
                if(imagenumber==9)
                {
                    imagenumber=1
                    enemyaction=0
                    enemyactiontime.interval=90
                    actionend=true

                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/closeattic/close11.png";break;
                case 2:playerImage.source="../../assets/player/action/closeattic/close12.png";break;
                case 3:playerImage.source="../../assets/player/action/closeattic/close13.png";break;
                case 4:playerImage.source="../../assets/player/action/closeattic/close14.png";break;
                case 5:playerImage.source="../../assets/player/action/closeattic/close15.png";break;
                case 6:playerImage.source="../../assets/player/action/closeattic/close16.png";break;
                case 7:playerImage.source="../../assets/player/action/closeattic/close17.png";break;
                case 8:playerImage.source="../../assets/player/action/closeattic/close18.png";break;
                    default:break;

                }
            }
            if(enemyaction==6){
                enemyactiontime.interval
                        =100
                if(imagenumber==5)
                {
                    imagenumber=1
                    enemyaction=0
                   enemyactiontime.interval=90


                }
                switch(imagenumber)
                {
                case 1:playerImage.source="../../assets/player/action/houtui/11.png";break;
                case 2:playerImage.source="../../assets/player/action/houtui/12.png";break;
                case 3:playerImage.source="../../assets/player/action/houtui/13.png";break;
                case 4:playerImage.source="../../assets/player/action/houtui/14.png";break;
                    default:break;


                }
            }
        }


    }

}
