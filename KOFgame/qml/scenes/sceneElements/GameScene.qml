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

    signal toGameOver
    signal scoreChanged
    property double gamescore: 100

    property alias enemyplayer: enemy

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //背景的背景
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    //可移动的背景图片
    ParallaxScrollingBackground {
        sourceImage: "../assets/background/layer2.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3, 0)
    }
    ParallaxScrollingBackground {
        sourceImage: "../assets/background/layer1.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        ratio: Qt.point(0.6, 0)
    }

    //可移动的整体组件，包含level 和 player / player2
    Item {
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        property double beforexoffsets
        property double latterxoffsets
        x: offset()

        //物理世界设置
        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            debugDrawVisible: true // enable this for physics debugging
            z: 1000

            onPreSolve: {

                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if (entityB.entityType === "platform"
                        && entityA.entityType === "player"
                        && entityA.y + entityA.height > entityB.y) {
                    //by setting enabled to false, they can be filtered out completely
                    //-> disable cloud platform collisions when the player is below the platform
                    contact.enabled = true
                    console.debug("11")
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
            x: 11 * gameScene.gridSize
            y: 4 * gameScene.gridSize
            playerController: controller
            contactid: play1
            onXChanged: {
                if (Math.abs(player.x - enemy.x) >= 11 * gameScene.gridSize) {
                    if (player.x < player2.x)
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

        // 玩家2
        //        Player {
        //            id: player2
        //            x: 18.5 * gameScene.gridSize
        //            y: 4* gameScene.gridSize
        //            myxAxis: controller2.xAxis
        //            playerController: controller2
        //            contactid: play2
        //            onXChanged: {
        //                if(Math.abs(player.x-player2.x)>=11*gameScene.gridSize){
        //                    if(player.x>player2.x)
        //                        player2.x = player.x-11*gameScene.gridSize
        //                    else
        //                        player2.x = player.x+11*gameScene.gridSize
        //                }
        //            }
        //        }
        //敌人
        Enemy {
            id: enemy
            x: 18.5 * gameScene.gridSize
            y: 4 * gameScene.gridSize
            //            myxAxis: controller2.xAxis
            //            playerController: controller2
            //            contactid: play2
            onXChanged: {
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
            }
        }

        Component {
            id: enemyprojectile
            Emprojectile {
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
        if ((enemy.x + player.x) / 2 <= 23 * gameScene.gridSize)
            if (Math.abs(player.x - enemy.x) <= 12.5 * gameScene.gridSize) {
                viewPort.beforexoffsets = 6.25 * gameScene.gridSize - (player.x + enemy.x) / 2
                viewPort.latterxoffsets = viewPort.beforexoffsets
                return viewPort.beforexoffsets
            } else {
                return viewPort.latterxoffsets
            }
    }

    // 键盘绑定动作
    Keys.forwardTo: [controller, controller2]
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
            console.log("fire")
            var offset = Qt.point(gameScene.gridSize, 0)

            //如果我们击倒或倒退，就跳伞。
            if (offset.x <= 0)
                return

            // 确定我们想把子弹射到哪里
            var realX = enemy.x - player.x /*scene.gameWindowAnchorItem.width*/
            //var ratio = offset.y / offset.x
            var realY = /*(realX * ratio) + */ enemy.y
            var destination
            if (realX > 0) {
                destination = Qt.point(-viewPort.width, realY)
            } else if (realX < 0) {
                destination = Qt.point(viewPort.width, realY)
            }

            // 确定我们拍摄的距离
            var offReal = Qt.point(realX - enemy.x, realY - enemy.y)
            var length = Math.sqrt(
                        offReal.x * offReal.x + offReal.y * offReal.y)
            var velocity = 140 // 弹丸速度应为每秒480PT。
            var realMoveDuration = length / velocity * 1000 // 乘以1000，因为弹丸的持续时间是毫秒。

            entityManager.createEntityFromComponentWithProperties(
                        enemyprojectile, {
                            destination: destination,
                            moveDuration: realMoveDuration,
                            x2: enemy.x,
                            y2: enemy.y
                        })
        }
    }

    OperationInterface {
        anchors.fill: parent
        onControllerPositionChanged: {
            controller.xAxis = controllerDirection.x
            controller.yAxis = controllerDirection.y
        }
        onAttackPressed: {
            socket.sendState("fire", isAttack)
            var offset = Qt.point(gameScene.gridSize, 0)

            //如果我们击倒或倒退，就跳伞。
            if (offset.x <= 0)
                return

            var realX = player.x - enemy.x /*scene.gameWindowAnchorItem.width*/
            //var ratio = offset.y / offset.x
            var realY = /*(realX * ratio) + */ enemy.y
            var destination
            if (realX > 0) {
                destination = Qt.point(-viewPort.width, realY)
            } else if (realX < 0) {
                destination = Qt.point(viewPort.width, realY)
            }

            // 确定我们拍摄的距离
            var offReal = Qt.point(realX - player.x, realY - player.y)
            var length = Math.sqrt(
                        offReal.x * offReal.x + offReal.y * offReal.y)
            var velocity = 140 // 弹丸速度应为每秒480PT。
            var realMoveDuration = length / velocity * 1000 // 乘以1000，因为弹丸的持续时间是毫秒。

            entityManager.createEntityFromComponentWithProperties(projectile, {
                                                                      destination: destination,
                                                                      moveDuration: realMoveDuration,
                                                                      x2: player.x,
                                                                      y2: player.y
                                                                  })
            console.log("attach pressed: " + isAttack)
        }
        onJumpPressed: {
            player.jump()
            console.log("Jump pressed: " + isJump)
        }
        onUnsetPressed: {
            console.log("unset pressed: " + isUnset)
        }
        PlatformerImageButton {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 80
            height: 50
            color: "yellow"
            text: "OVER"
            onClicked: {
                finishScene.gamescore = gameScene.gamescore
                toGameOver()
            }
        }
    }
}
