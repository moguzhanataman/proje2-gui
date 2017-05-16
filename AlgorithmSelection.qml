import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    property alias radio1: radio1
    property alias radio2: radio2
    property alias radio3: radio3

//    onCurrentIndexChanged: {
//        radio1.checked = currentIndex == 1
//        radio2.checked = currentIndex == 2
//        radio3.checked = currentIndex == 3

//        console.log("Current index = " + currentIndex)
//    }

    GroupBox {
        id: groupBox
        x: 13
        y: 10
        width: 200
        height: 173
        anchors.horizontalCenterOffset: 3
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: true
        title: qsTr("Select Algorithm")

        RadioButton {
            id: radio1
            checked: true
            x: 0
            y: 0
            text: qsTr("Edge")
            onClicked: {
                currentIndex = 1
            }
        }

        RadioButton {
            id: radio2
            x: -2
            y: 43
            text: qsTr("Sobel")
            onClicked: {
                currentIndex = 2
            }
        }

        RadioButton {
            id: radio3
            x: -2
            y: 86
            text: qsTr("Canny")
            onClicked: {
                currentIndex = 3
            }
        }
    }
}
