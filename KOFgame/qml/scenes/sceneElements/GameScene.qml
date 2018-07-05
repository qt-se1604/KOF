import QtQuick 2.0
import VPlay 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../common"
import "../../entities"
import "../dialogs"
import "../../levels"

SceneBase {
    id: gameScene
    gridSize: 32
    property int offsetBeforeScrollingStarts: 400
    property alias playerX: player.x
    property alias enemyplayer: enemy
    property alias timeereduce:timeereduce
    property alias timeeetotal:timeeetotal
    property alias totaltime: gametruetime.totaltime

    property alias viewPort:viewPort

    signal toGameOver
    signal scoreChanged
    property double gamescore: 100
    property bool gameWon

    property int playerID
    property int gametime
    property int gamemusic
    property int gamebackground


    onGamebackgroundChanged: {
        if(gamebackground == 1)
            backgroud.source = "../../../assets/background/beijing1.jpg"
        else
            backgroud.source = "../../../assets/background/beijing2.jpg"
    }




    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }


    //背景的背景
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        Image {
            id: backgroud
            anchors.fill:parent

        }
    }


    Blood{
        id:bloodall
        bloodvolume1.width:playerID == 1 ? player.blood : enemy.blood
        bloodvolume2.width:playerID == 2 ? player.blood : enemy.blood
        bloodvolume2.onWidthChanged:
        {
            bloodvolume2.parent.x+=10
            if(bloodvolume2.width<=0)
            {
                bloodvolume2.parent.x=parent.x+340
                finishScene.gameWon = true
                toGameOver()

            }

        }
        bloodvolume1.onWidthChanged: {
            if(bloodvolume1.width<=0)
            {

                finishScene.gameWon = false
                toGameOver()

            }
        }
    }

    Rectangle{
        id  : gametruetime
        anchors.top :parent.top
        anchors.topMargin: 0.5*gameScene.gridSize
        anchors.horizontalCenter: parent.horizontalCenter
//        width: 1*gameScene.gridSize
//        height: 1*gameScene.gridSize


        property int totaltime
        property alias timeereduce:timeereduce
        property alias timeeetotal:timeeetotal
        //            property alias totaltime:totaltime
        totaltime: gametime==1?60:90
        Timer{
            id: timeeetotal
            running: false
            repeat: false
            interval: gametime == 1 ? 6000 : 9000
            onTriggered: {
//                timeeetotal.stop()
//                timeereduce.stop()

                toGameOver()

            }
        }

        Timer{
            id: timeereduce
            running: false
            interval: 1000
            repeat: true
            onTriggered: gametruetime.totaltime -= 1
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "red"
            text: gametruetime.totaltime
        }
    }

    //可移动的整体组件，包含level 和 player / player2
    Item {
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        property double beforexoffsets
        property double latterxoffsets
        property alias player: player
        property alias enemy: enemy

        property alias gametruetime: gametruetime
        x: offset()

        //物理世界设置
        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 20)
            debugDrawVisible: true // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if (entityB.entityType === "enemy"
                        && entityA.entityType === "player") {
                    contact.enabled = true
                }
            }
        }

        // 地图设置
        Level1 {
            id: level
        }



        // 玩家1
        Player {
            id: player
            x: playerID == 1 ? 11 * gameScene.gridSize : 18.5 * gameScene.gridSize
            y: playerID == 1 ? 4 * gameScene.gridSize : 4 * gameScene.gridSize
            playerController: controller

            onXChanged: {
                if(player.x <= 0 ){
                    player.x = 0
                }
                else if(player.x >= 31*gameScene.gridSize){
                    player.x = 31*gameScene.gridSize
                }
                if (Math.abs(player.x - enemy.x) >= 11 * gameScene.gridSize) {
                    if (player.x < enemy.x)
                        player.x = enemy.x - 11 * gameScene.gridSize
                    else
                        player.x = enemy.x + 11 * gameScene.gridSize
                }
            }
            Timer {
                interval: 5
                repeat: true
                running: true
                onTriggered: {
                    socket.sendState("x", player.x)
                    socket.sendState("y", player.y)
                }
            }
        }


        //敌人
        Enemy {
            id: enemy
            x: playerID == 1 ? 11 * gameScene.gridSize : 18.5 * gameScene.gridSize
            y: playerID == 1 ? 4 * gameScene.gridSize : 4 * gameScene.gridSize
            onXChanged: {
                if(enemy.x<= 0 ){
                    enemy.x = 0
                }
                else if(enemy.x>=31*gameScene.gridSize){
                    enemy.x = 31*gameScene.gridSize
                }
                if (Math.abs(player.x - enemy.x) >= 11 * gameScene.gridSize) {
                    if (player.x > enemy.x)
                        enemy.x = player.x - 11 * gameScene.gridSize
                    else
                        enemy.x = player.x + 11 * gameScene.gridSize
                }
            }
        }
        //子弹
        Component {
            id: projectile
            Projectile {
                parent: viewPort
            }
        }

        Component {
            id: enemyprojectile
            Emprojectile {
                parent: viewPort
            }
        }
        //近战
        Component {
            id: closerangattack
            Closerangattack {
                parent: viewPort
            }
        }
        //判死传感器
        ResetSensor {
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                player.x = 11 * gameScene.gridSize
                player.y = 4 * gameScene.gridSize
            }
            // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
            Rectangle {
                anchors.fill: parent
                color: "yellow"
                opacity: 0.5
            }
        }
    }
    //地图位移函数
    function offset() {
        if ((enemy.x + player.x) / 2 <= 23 * gameScene.gridSize&& (enemy.x + player.x) / 2>=6.25*gameScene.gridSize)
            if (Math.abs(player.x - enemy.x) <= 12.5 * gameScene.gridSize) {
                viewPort.beforexoffsets = 6.25 * gameScene.gridSize - (player.x + enemy.x) / 2
                viewPort.latterxoffsets = viewPort.beforexoffsets
                return viewPort.beforexoffsets
            } else {
                return viewPort.latterxoffsets
            }
    }

    // 键盘绑定动作
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            if (actionName == "up") {
                console.debug("jump")
                player.jump()
            }
        }
    }
    Connections {
        target: socket
        onFireChanged: {
            //            console.log("fire")
            if(isFire){
                if(enemy.actionend==true){
                    enemy.imagenumber=1
                    enemy.actionend=false
                    enemy.enemyaction=3
                }
                fireother()
            }
        }
    }
    Connections {
        target: socket
        onCloseattackChanged: {
            console.log("fdssssssssssssssssssssss")
            if(isattack){
                if(enemy.actionend==true){
                    enemy.imagenumber=1
                    enemy.actionend=false
                    enemy.enemyaction=5
                }
                attackother()
            }
        }
    }

    Connections{
        target: socket
        onJumpChanged:{
            enemy.enemyaction=4
            enemy.imagenumber = 1
        }
    }

    Connections{
        target: player
        onBeenAttacked:{
            beenattackedtimer.running = true
            if(player.x>enemy.x)
                player.x+=0.5*gameScene.gridSize
            else if(player.x<enemy.x)
                player.x-=0.5*gameScene.gridSize
        }
    }
    Timer{
        id: beenattackedtimer
        interval: 2000
        repeat: false
        running: false
        onTriggered: {
            player.beenattack = false
        }
    }

    OperationInterface {
        id: operateface
        anchors.fill: parent
        onControllerPositionChanged: {
            if(player.beenattack == false){
                controller.xAxis = controllerDirection.x
                controller.yAxis = controllerDirection.y
                if(controller.xAxis>0)
                {
                    player.playeraction=1
                }
                else if(controller.xAxis<0)
                {
                    player.playeraction=2
                }
                player.imagenumber=1
            }
        }
        onAttackPressed: {
            if(player.beenattack == false){
                if(operateface.farattackinterval === 0){
                    farattacktimer.running = true
                    operateface.farattackinterval += 1
                    if(player.actionend==true){
                        player.imagenumber=1
                        player.actionend=false
                        player.playeraction=3
                    }
                    socket.sendState("fire", isAttack)
                    firemy()
                }
            }
        }
        onJumpPressed: {
            if(player.beenattack == false){
                if(player.actionend==true){
                    player.imagenumber=1
                    player.actionend=false
                    player.playeraction=4
                }
                player.jump()
                socket.sendState("jump", isJump)
            }
        }
        onCloseRangAttackPressed: {
            if(player.beenattack == false){
                if(operateface.closeattackinterval === 0){
                    closeattacktimer.running = true
                    operateface.closeattackinterval++
                    if(player.actionend==true){
                        player.imagenumber=1
                        player.actionend=false
                        player.playeraction=5
                    }
                    socket.sendState("attack", true)
                    attackmy()
                }
            }
        }

        PlatformerImageButton {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 80
            height: 50
            color: "yellow"
            text: "OVER"
            onClicked: {
                toGameOver()
            }
        }
    }
    Timer{
        id:closeattacktimer
        interval:2000
        repeat: false
        running: false
        onTriggered: {
            operateface.closeattackinterval=0
        }
    }
    Timer{
        id:farattacktimer
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            operateface.farattackinterval=0
        }
    }


    function fireother(){
        var offset = Qt.point(gameScene.gridSize, 0)

        //如果我们击倒或倒退，就跳伞。
        if (offset.x <= 0)
            return

        // 确定我们想把子弹射到哪里
        var realX = enemy.x - player.x /*scene.gameWindowAnchorItem.width*/
        var destination
        if (realX > 0) {
            destination = Qt.point(-15*gameScene.gridSize, enemy.y)
        } else if (realX < 0) {
            destination = Qt.point(15*gameScene.gridSize, enemy.y)
        }


        entityManager.createEntityFromComponentWithProperties(
                    enemyprojectile, {
                        destination: destination,
                        x2: enemy.x,
                        y2: enemy.y
                    })
    }

    function firemy(){
        var offset = Qt.point(gameScene.gridSize, 0)

        //如果我们击倒或倒退，就跳伞。
        if (offset.x <= 0)
            return

        var realX = player.x - enemy.x /*scene.gameWindowAnchorItem.width*/
        var destination
        if (realX > 0) {
            destination = Qt.point(-15*gameScene.gridSize, player.y)
        } else if (realX < 0) {
            destination = Qt.point(15*gameScene.gridSize,player.y)
        }

        entityManager.createEntityFromComponentWithProperties(projectile, {
                                                                  destination: destination,
                                                                  x2: player.x,
                                                                  y2: player.y
                                                              })
    }
    function attackmy(){
        var attackoffset
        if(playerID==1){

            if(player.x >enemy.x)
                attackoffset = Qt.point(-gameScene.gridSize*6,gameScene.gridSize)
            else
                attackoffset = Qt.point(gameScene.gridSize*2.5,gameScene.gridSize)
        }
        else if(playerID==2){
            if(player.x >enemy.x)
                attackoffset = Qt.point(-gameScene.gridSize*6,gameScene.gridSize)
            else
                attackoffset = Qt.point(gameScene.gridSize*2.5,gameScene.gridSize)

        }

        entityManager.createEntityFromComponentWithProperties(closerangattack, {
                                                                  x:player.x+attackoffset.x,
                                                                  y:0/*+ attackoffset.y*/
                                                              })
    }

    function attackother(){
        var attackoffset
        if(playerID==1){

            if(player.x <enemy.x)
                attackoffset = Qt.point(-gameScene.gridSize*6,gameScene.gridSize)
            else
                attackoffset = Qt.point(gameScene.gridSize*2.5,gameScene.gridSize)
        }
        else if(playerID==2){
            if(player.x <enemy.x)
                attackoffset = Qt.point(-gameScene.gridSize*6,gameScene.gridSize)
            else
                attackoffset = Qt.point(gameScene.gridSize*2.5,gameScene.gridSize)

        }

        entityManager.createEntityFromComponentWithProperties(closerangattack, {
                                                                  x:enemy.x+attackoffset.x,
                                                                  y:0/*+ attackoffset.y*/
                                                              })
    }

}

