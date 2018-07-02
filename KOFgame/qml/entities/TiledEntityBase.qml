import QtQuick 2.0
import VPlay 2.0

EntityBase{
    id: titledRntity
    property int column: 0
    property int row: 0
    property int size

    x: row*gameScene.gridSize
    y: level.height - (column+ 1)*gameScene.gridSize
    width: gameScene.gridSize * size
    height: gameScene.gridSize
}
