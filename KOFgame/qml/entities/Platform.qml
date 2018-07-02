import QtQuick 2.0
import VPlay 2.0

TiledEntityBase{
    id:platform
    entityType: "platform"

    size:2

    Row{
        id:tileRow
        Tile{
            pos:left
            image:"../../assets/platform/left.png"
        }
        Repeater{
            model:size -2
            Tile{
                pos:"mid"
                image:"../../assets/platform/mid" +index%2 +".png"
            }
        }
        Tile{
            pos:"right"
            image:"../../assets/platform/right.png"
        }
    }
    BoxCollider{
        id:collider
        anchors.fill:parent
        bodyType:Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player")
                player.contacts++
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player")
                player.contacts--
        }
    }
}
