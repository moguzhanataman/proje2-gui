import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Rectangle {
    id: rulerVertical
    width: 40
    height: 296

    property alias maxVal: gauge.maximumValue

    Gauge {
        id: gauge
        height: 5
        maximumValue: 42
        anchors.fill: parent
        anchors.margins: 0

//        value: 5
//        Behavior on value {
//            NumberAnimation {
//                duration: 1000
//            }
//        }

//        style: GaugeStyle {
//            valueBar: Rectangle {
//                implicitWidth: 16
//                color: Qt.rgba(gauge.value / gauge.maximumValue, 0, 1 - gauge.value / gauge.maximumValue, 1)
//            }
//        }
    }
}
