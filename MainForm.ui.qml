import QtQuick 2.6
import QtQuick.Controls 2.1

Rectangle {
    width: 1078
    height: 700
    property alias stickMan: stickMan
    transformOrigin: Item.Center
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
            stickMan.x = x * 3
        }

        onSetPosY: {
            console.log(qsTr('position from top: ' + y))
            stickMan.y = y * 3
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

        Rectangle {
            id: fixedImageFrame
            //x: 102
            //y: 64
            width: 630
            height: 444
            x: 101
            y: 112
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

            Image {
                id: image1
                x: -253
                y: 200
                rotation: 90
                width: 458
                height: 56
                source: "template/Ruler15.png"
            }
        }

        Rectangle {
            id: hardwareSettings
            x: 818
            y: 185
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
    }

    Rectangle {
        id: rectangle
        x: 819
        y: 21
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

    Image {
        id: image
        x: 101
        y: 56
        width: 645
        height: 56
        source: "template/Ruler21.png"
    }
}
