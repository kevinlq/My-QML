import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

Rectangle {
    visible: true;
    height: 360;
    width: 460;

    property var tempValue: 1;
    property var fishSpeed: 10
    property real dpScale: 1.5
    readonly property real dpi: Math.max(Screen.pixelDensity * 25.4/160*dpScale,1)

    Timer {
        id: reTime
        interval: 100
        repeat: true
        running: false

        onTriggered: {
            tempValue = (tempValue + fishSpeed) %5400;
            m_fish.setCurrentValue(tempValue);
            m_fish.updateCanvas();
            console.log("update:"+tempValue)
        }
    }

    ComboBox {
        id: speed
        width: 100
        anchors.left: parent.left
        anchors.leftMargin: 10
        model: [ 5, 10, 15, 20, 25, 30, 35, 40 ]

        onActivated: {
            fishSpeed = parseInt(speed.currentText);
            console.log(speed.currentText)
        }
    }

    Button {
        id:btnStart
        text: "start"
        width: 80
        height: 40
        anchors.left: speed.right
        anchors.leftMargin: 10

        onClicked: {
            reTime.running = true;
        }
    }

    Button {
        id: btnStop
        text: "stop"
        width: 80
        height: 40
        anchors.left: btnStart.right
        anchors.leftMargin: 10

        onClicked: {
            reTime.running = false;
        }
    }

    Button {
        id: btnRestore
        text: "restore"
        width: 80
        height: 40
        anchors.left: btnStop.right
        anchors.leftMargin: 10

        onClicked: {
            m_fish.setCurrentValue(0);
            m_fish.setFinsAlgle(90)
            m_fish.updateCanvas();
        }
    }

    MyFish {
        id: m_fish
        width: m_fish.getIntrinsicWidth()*dpi;
        height: m_fish.getIntrinsicHeight()*dpi;
        anchors.centerIn: parent
    }

    //        CanvansDemo {
    //            id: demo
    //            width: 500
    //            height: 500
    //        }

}

