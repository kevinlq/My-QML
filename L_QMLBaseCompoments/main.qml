import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import "./Common/Compoments"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    color: "#223333"

    Column {
        spacing: 10
        anchors.leftMargin: parent.width *0.6
        LQBaseText {
            id: txt
            text: "这个是Text组件"
            width: parent.width
            color: "#FFFFFF"
        }

        Button {
            text: "buttonr"
        }
    }
}
