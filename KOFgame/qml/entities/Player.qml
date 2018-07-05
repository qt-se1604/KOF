import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"
    width: 2.5 * gameScene.gridSize
    height: 3.5 * gameScene.gridSize

    property bool pressedJump: false

    property double myxAxis
    property var playerController
    property int contacts: 0
    property var contactid

    property alias linearVelocityX: collider.linearVelocity.x
    property alias forcex: collider.force.x
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x



    property double blood: 100
    property int imagenumber: 1
    property int playerid
    property int playeraction: 0
    property bool  playerface: true
    property bool actionend:true

    property bool beenattack:false
    signal beenAttacked

    property bool beencloseattack:false
    signal beenCloseAttacked

    state: contacts > 0 ? "walking" : "jumping"
    onStateChanged: console.debug("player.state " + state)

    MultiResolutionImage {
        id:playerImage
        anchors.fill: collider

    }

    BoxCollider {
        id: collider
        height: parent.height
        width: parent.width * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        bodyType: Body.Dynamic
        fixedRotation: true
        sleepingAllowed: false
        force: Qt.point(playerController.xAxis * 170 * gameScene.gridSize, 0)
        onLinearVelocityChanged: {
            if (linearVelocity.x > 5 * gameScene.gridSize) {
                linearVelocity.x = 5 * gameScene.gridSize
                console.debug("aaa")
            }
            if (linearVelocity.x < -5 * gameScene.gridSize)
                linearVelocity.x = -5 * gameScene.gridSize
        }
        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            if (collidedEntity.entityType === "Enemyprojectile") {
                beenattack = true
                beenAttacked()
                playeraction=6
                imagenumber=1
                if(blood>0)
                {
                    blood-=10
                }
                collidedEntity.removeEntity()
            }
            else if(collidedEntity.entityType === "Enemycloserangattack"){
                beencloseattack = true
                beenCloseAttacked()
                playeraction=6
                imagenumber=1
                if(blood>0){
                    blood -= 20
                }
            }
        }
    }
    Timer {
        id: updateTimer
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = playerController.xAxis
            if (xAxis === 0) {
                if (Math.abs(player.horizontalVelocity) > 10)
                    player.horizontalVelocity /= 1.5
                else
                    player.horizontalVelocity = 0
            }
        }
    }
    Timer{
        id:playeractiontime
        interval:90
        running:true
        repeat: true
        onTriggered: {

            imagenumber+=1
            if(player.x - enemy.x<0)
            {

                playerface=true

            }
            else{

                playerface=false


            }
            selectImage()


        }
    }
    function selectImage(){
        if(playerface){
            if(playeraction==0)
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
            if(playeraction==1){
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
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
            if(playeraction==2){
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
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
            if(playeraction==3){
                playeractiontime.interval
                =120
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            if(playeraction==4){
                playeractiontime.interval
                =130
                if(imagenumber==8)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            if(playeraction==5){
                playeractiontime.interval
                =100
                if(imagenumber==9)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            if(playeraction==6){
                playeractiontime.interval
                        =100
                if(imagenumber==5)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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

        }else{
            if(playeraction==0)
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

                default:break;
                }
            }
            if(playeraction==1){
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
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
            if(playeraction==2){
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
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
            if(playeraction==3){
                playeractiontime.interval
                =120
                if(imagenumber==6)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            if(playeraction==4){
                playeractiontime.interval
                =130
                if(imagenumber==8)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            if(playeraction==5){
                playeractiontime.interval
                =100
                if(imagenumber==9)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90
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
            }if(playeraction==6){
                playeractiontime.interval
                =100
                if(imagenumber==5)
                {
                    imagenumber=1
                    playeraction=0
                    playeractiontime.interval=90


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

        }


    }

    function jump() {
        console.debug("jump requested at player.state " + state)
        if (player.state == "walking") {
            console.debug("do the jump")
            collider.linearVelocity.y = -13.125 * gameScene.gridSize
        }
    }
}
