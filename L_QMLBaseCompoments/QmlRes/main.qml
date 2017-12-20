import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import "./Common/Compoments"

Window {
    visible: true
    width: 400
    height: 320
    title: qsTr("Hello World")

    color: "#223333"

    Column {
        spacing: 10
        anchors.left: parent.left
        anchors.leftMargin: 20
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
