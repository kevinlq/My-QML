import QtQuick 2.0

Item {
    width: 600
    height: 600

    Rectangle {
        width: 100; height: 100
        color: "red"

        NumberAnimation on x { to: 50; duration: 1000 }
        NumberAnimation on y {to: 100;duration: 2000}
    }

}
