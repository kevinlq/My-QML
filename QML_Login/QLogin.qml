import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

Window {
    id: main
    visible: true
    width: 600
    height: 320

    Rectangle {
        id: loginRect
        width: parent.width / 2 + 10;
        height: parent.height / 2

        TextInput {
            id: inputName
            color: "red"
        }

        TextInput {
            id: inputPwd;
        }

    }
}
