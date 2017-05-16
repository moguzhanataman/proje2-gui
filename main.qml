import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Window {
    visible: true
    width: 1300
    height: 760
    title: qsTr("Project II Interface")

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
        }

        startButton.onClicked: {
            client.sendStart(currentIndex)
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



        anchors.fill: parent
//        mouseArea.onClicked: {

//        }
    }
}
