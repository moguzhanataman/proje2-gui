import QtQuick 2.6
import QtQuick.Controls 2.1

Rectangle {
    width: 1078
    height: 700
    property alias fixedImageFrame: fixedImageFrame

    property int currentIndex: 1

    property alias connectButton: connectButton
    property alias ipAddrTextField: ipAddrTextField
    property alias startButton: startButton
    property alias quitButton: quitButton
    property alias continueButton: continueButton
    property alias pauseButton: pauseButton
    property alias hardwareSettings: hardwareSettings

    property alias mouseArea: mouseArea

    Connections {
        target: client
        onSetRotation: {
            console.log(qsTr('rotation: ' + degree))
            stickMan.rotation = degree
        }

        onSetPosX: {
            console.log(qsTr('position from left: ' + x))
            stickMan.x = x
        }

        onSetPosY: {
            console.log(qsTr('position from top: ' + y))
            stickMan.y = y
        }

        onSetHeight: {
            stickMan.width = width * (56.0 / 640) / 2
        }

        onSetWidth: {
            stickMan.height = height * (42.0 / 480) / 2
        }

        onStopTimer: {
            textTimer.running = false
        }

        onStartTimer: {
            // restart chronometer
            chronoText.text = "00:00:00"
            console.log(chronoText.text)

            // move cam to 22,28
            stickMan.x = 22
            console.log(stickMan.x)
            stickMan.y = 28
            console.log(stickMan.y)

            textTimer.running = true
            console.log("running true oldu")
            if (startTime == 0) {
                console.log("start time sifir")
                startTime = new Date().getTime()
            }
        }

        onStickManFound: {
            console.log("stick-man resmini getir.")
            stickMan.source = "template/stick-man-vector.svg"
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
            width: 630
            height: 444
            color: "#ffffff"
            z: 1
            border.width: 1

            Image {
                id: stickMan
                x: 8
                y: 8
                width: 64
                height: 64
                source: "template/camera-icon.png"
            }
        }

        Rectangle {
            id: hardwareSettings
            x: 800
            y: 225
            width: 217
            height: 331
            color: "#ffffff"
            border.width: 1

            Button {
                id: pauseButton
                x: 117
                y: 225
                width: 92
                height: 40
                text: qsTr("Pause")
                opacity: 1
            }

            Button {
                id: continueButton
                x: 9
                y: 281
                width: 100
                height: 38
                text: qsTr("Continue")
                opacity: 1
            }

            Button {
                id: quitButton
                x: 117
                y: 281
                width: 92
                height: 38
                text: qsTr("Quit")
                opacity: 1
            }

            Button {
                id: startButton
                x: 9
                y: 225
                text: qsTr("Start")
            }

            AlgorithmSelection {
                id: algorithmSelection
                x: 109
                y: 16
            }
        }

        Ruler {
            id: rulerVert1
            x: 44
            y: 64
            width: 52
            height: 296
            rotation: 0
            maxVal: 15
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
    }

    Text {
        id: text2
        x: 57
        y: 28
        text: qsTr("cm")
        font.pixelSize: 20
    }

    Rectangle {
        id: rectangle
        x: 800
        y: 64
        width: 217
        height: 153
        color: "#ffffff"
        radius: 1
        border.width: 1

        TextField {
            id: ipAddrTextField
            x: 8
            y: 37
        }

        Label {
            id: label
            x: 8
            y: 14
            text: qsTr("IP Address")
        }

        Button {
            id: connectButton
            x: 8
            y: 97
            text: qsTr("Connect")
        }
    }
}
