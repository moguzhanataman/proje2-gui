import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

import "./Global.js" as Global

Window {
    visible: true
    width: 1300
    height: 760
    title: qsTr("Project II Interface")

    property double startTime: 0

    MainForm {
        id: mainForm
        onCurrentIndexChanged: {
            console.log("Current index = " + currentIndex)
        }

        pauseButton.onClicked: {
            client.sendPause()
        }

        continueButton.onClicked: {
            client.sendContinue()
        }

        quitButton.onClicked: {
            client.sendQuit()

            textTimer.running = false
        }

        startButton.onClicked: {
            client.sendStart(currentIndex)
//            Global.previousTime = new Date


//            client.initClock()
//            clock.init()
//            clockTextEdit.text = clock.getTime()
        }

        connectButton.onClicked: {
            client.init(ipAddrTextField.text)
//            client.setIpAddr(ipAddrTextField.text)
        }

//        startButton.onClicked: {
//            client.sendStart(current)
//        }

        // Radio Button handlers


//        rebootButton.onClicked: {
//            dial.increase()
////            stickMan.rotation = (stickMan.rotation + 30) % 360
////            console.log(qsTr('' + stickMan.rotation))
//        }

        Rectangle {
            id: chronoRect
            width: 217
            height: 162
            x: 800
            y: 571

            border.width: 1

            Text {
                id: chronoText
                width: 150
                height: 40
                text: "00:00:00"
                fontSizeMode: Text.HorizontalFit
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                transformOrigin: Item.Center
                font.pointSize: 12
            }

            Timer {
                id: textTimer
                interval: 1000
                repeat: true
                running: false
                triggeredOnStart: true

                onTriggered: {
                    if (startTime != 0) {
                        chronoText.text = timeConverter(Math.round((new Date().getTime() - startTime)/1000))
                    }
                }

                function timeConverter(sec_num) {
                    var hours   = Math.floor(sec_num / 3600);
                    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
                    var seconds = sec_num - (hours * 3600) - (minutes * 60);

                    if (hours   < 10) {hours   = "0"+hours;}
                    if (minutes < 10) {minutes = "0"+minutes;}
                    if (seconds < 10) {seconds = "0"+seconds;}

                    return hours+':'+minutes+':'+seconds;
                }

            }

            Label {
                id: chronoLabel
                x: 34
                y: 15
                width: 150
                height: 27
                text: qsTr("Chronometer")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
            }
        }


        anchors.fill: parent
//        mouseArea.onClicked: {

//        }
    }
}
