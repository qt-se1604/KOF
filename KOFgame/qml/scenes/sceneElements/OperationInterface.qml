import QtQuick 2.0
import VPlay 2.0

Item {
    signal controllerPositionChanged(point controllerDirection)
    signal attackPressed(bool isAttack)
    signal jumpPressed(bool isJump)
    signal closeRangAttackPressed(bool isUnset)

    property int closeattackinterval:0
    property int farattackinterval: 0
//    state: contractss ==0?"able":"unable"

    //buttoms
    JoystickControllerHUD {
        id: controllerHub
        height: parent.height / 4
        width: height
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        backgroundImageSource: "../../../assets/ui/Control.png"
        thumbSource: "../../../assets/ui/ControlCenter.png"
        onControllerXPositionChanged: {
            controllerPositionChanged(Qt.point(controllerXPosition, controllerYPosition))
        }
        onControllerYPositionChanged: {
            controllerPositionChanged(Qt.point(controllerXPosition, controllerYPosition))
        }
    }
    Rectangle {
        id: attack
        height: parent.height / 4
        width: height
        radius: width
        anchors.right: parent.right
        anchors.rightMargin: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        Image {
            anchors.fill: parent
            source: "../../../assets/ui/FireButton.png"
        }
        MultiPointTouchArea {
            anchors.fill: parent
            touchPoints: TouchPoint {
                id: attackTouchPoint
                onPressedChanged: {
                    attackPressed(pressed)
                }
            }
        }
    }
    Rectangle {
        id: jump
        height: 40
        width: height
        radius: height
        anchors.left: attack.right
        anchors.leftMargin: 10
        anchors.top: attack.top
        Image {
            anchors.fill: parent
            source: "../../../assets/ui/JumpButton.png"
        }
        MultiPointTouchArea {
            anchors.fill: parent
            touchPoints: TouchPoint {
                id: jumpTouchPoint
                onPressedChanged: {
                    jumpPressed(pressed)
                }
            }
        }
    }
    Rectangle {
        id: closeRangAttack
        height: 40
        width: height
        radius: height
        anchors.left: attack.right
        anchors.leftMargin: 10
        anchors.bottom: attack.bottom
        Image {
            anchors.fill: parent
            source: "../../../assets/ui/UnsetButton.png"
        }
        MultiPointTouchArea {
            anchors.fill: parent
            touchPoints: TouchPoint {
                id: closeRangAttackTouchPoint
                onPressedChanged: {
                    closeRangAttackPressed(pressed)
                }
            }
        }
    }

    //status
    Rectangle {
        id: playerStatus
        height: parent.height / 10
        width: height * 2
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        radius: 6
        color: "#55bababa"
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 5
            text: qsTr("分数：")
        }
        Text {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 5
            text: "0"
        }
    }
}
