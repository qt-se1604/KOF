import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"
    width: 2.5 * gameScene.gridSize
    height: 4 * gameScene.gridSize

    property bool pressedJump: false

    property double myxAxis
    property var playerController
    property int contacts: 0
    property var contactid

    property alias linearVelocityX: collider.linearVelocity.x
    property alias forcex: collider.force.x
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x

    state: contacts > 0 ? "walking" : "jumping"
    onStateChanged: console.debug("player.state " + state)

    MultiResolutionImage {
        source: "../../assets/player/run.png"
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
                console.log("touched player")
                collidedEntity.removeEntity()
            }
            //        var otherEntity = other.getBody().target
            //        if(otherEntity.entityType === "platform" || otherEntity.entiryType === "ground"){
            //            console.log("Change to Walk")
            //            player.state = "walking"
            //        }
            //        if(pressedJump)
            //        {
            //            player.state = "walking"
            //            pressedJump = true;
            //        }
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

    function jump() {
        console.debug("jump requested at player.state " + state)
        if (player.state == "walking") {
            console.debug("do the jump")
            collider.linearVelocity.y = -13.125 * gameScene.gridSize
        }
    }
    //  function jump() {
    //      console.debug("jump requested at player.state " + state)
    //      pressedJump = true
    //      if (player.state == "walking") {
    //          player.state = "jumping"
    //          console.debug("do the jump")
    //          // for the jump, we simply set the upwards velocity of the collider
    //          collider.linearVelocity.y = -13.125 * gameScene.gridSize
    //      }
    //  }
}
