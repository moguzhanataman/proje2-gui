import QtQuick 2.6
import QtQuick.Controls 2.1

Rectangle {
    width: 1078
    height: 440
    property alias connectButton: connectButton
    property alias dialRotation: dialRotation
    property alias hardwareSettings: hardwareSettings

    property alias mouseArea: mouseArea
    property alias rebootButton: rebootButton

    Connections {
        target: client
        onSetRotation: {
            console.log(qsTr('rotation: ' + degree))
            stickMan.rotation = degree
        }

        onSetPosX: {
            console.log(qsTr('position from left: ' + x))
            stickMan.x = x * 2;
        }

        onSetPosY: {
            console.log(qsTr('position from top: ' + y))
            stickMan.y = y * 2;
        }
    }

    MouseArea {
        id: mouseArea
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: fixedImageFrame
            x: 102
            y: 64
            width: 420
            height: 296
            color: "#ffffff"
            z: 1
            border.width: 1

            Image {
                id: stickMan
                x: 0
                y: 0
                width: 100
                height: 100
                z: 100
                source: "template/stickman.png"
            }
        }

        Rectangle {
            id: hardwareSettings
            x: 556
            y: 64
            width: 217
            height: 296
            color: "#ffffff"
            border.width: 1

            Label {
                id: hardwareSettingsLabel
                x: 56
                y: 8
                text: qsTr("Hardware Settings")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                id: rebootButton
                x: 59
                y: 105
                width: 100
                height: 50
                text: qsTr("Reboot")
                opacity: 1
            }
        }

        Ruler {
            id: rulerVert1
            x: 44
            y: 64
            width: 52
            height: 296
            maxVal: 18
        }

        Ruler {
            id: rulerHor1
            x: 286
            y: -169
            width: 52
            height: 420
            maxVal: 21
            rotation: 90
        }

        Rectangle {
            id: stickManSettings
            x: 808
            y: 64
            width: 229
            height: 239
            color: "#ffffff"

            Label {
                id: rotationLabel
                x: 23
                y: 8
                text: qsTr("Rotation:")
            }

            Dial {
                id: dialRotation
                x: 23
                y: 28
                stepSize: 1
                to: 359
            }

            Rectangle {
                id: rectangle
                x: 0
                y: 255
                width: 229
                height: 103
                color: "#ffffff"

                TextEdit {
                    id: domainTextEdit
                    x: 8
                    y: 8
                    width: 213
                    height: 34
                    text: qsTr("Domain")
                    font.pixelSize: 12
                }

                Button {
                    id: connectButton
                    x: 65
                    y: 48
                    text: qsTr("Connect")
                }
            }
        }
    }

    Text {
        id: text2
        x: 57
        y: 28
        text: qsTr("cm")
        font.pixelSize: 20
    }
}
