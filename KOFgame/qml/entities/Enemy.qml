import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: enemy
    entityType: "enemy"
    width: 2.5 * gameScene.gridSize
    height: 4 * gameScene.gridSize
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
        gravityScale: 0
        //force: Qt.point(playerController.xAxis*170*gameScene.gridSize,0)
        //      onLinearVelocityChanged: {
        //          if (linearVelocity.x >  5*gameScene.gridSize){
        //              linearVelocity.x =  5*gameScene.gridSize
        //              console.debug("aaa")
        //          }
        //          if (linearVelocity.x < -5 * gameScene.gridSize)
        //              linearVelocity.x = -5 * gameScene.gridSize
        //      }
        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            if (collidedEntity.entityType === "projectile") {
                console.log("touched enemy")
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
}
