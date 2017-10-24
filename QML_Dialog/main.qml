import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Window {
    id: dialog_root
    visible: true

    width: 300; height: 200

    property string title: "value"
    property string content: "this is content"
    property string btnYesString: "yes"
    property string btnNoString: "no"
    property string titleBackImg: ""
    property string contentBackImg: ""

    //隐藏标题栏和按钮
    flags: Qt.FramelessWindowHint | Qt.window |  Qt.WindowStaysOnTopHint
    //设置为模态对话框
    modality: Qt.ApplicationModal

    /**
      自定义信号
      * accept: yes按钮被点击
      * regect: no按钮被点击
    */
    signal accept();
    signal reject();

    ColumnLayout{
        anchors.fill: parent

        //间距
        spacing: 0

        //标题栏
        Rectangle {
            id: titleBar
            Layout.fillWidth: parent
            implicitHeight: 30
            color: "#3b4146"

            //添加标题栏文字以及关闭按钮
            RowLayout {
                anchors.fill: parent
                spacing: 2

                MouseArea {
                    id: mouseControler
                    property point clickPos: "0,0"
                    Layout.fillHeight: parent
                    Layout.fillWidth: parent

                    Text {
                        id: title
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    onPressed: {
                        clickPos = Qt.point(mouse.x,mouse.y)
                    }

                    onPositionChanged: {
                        //计算鼠标的偏移量
                        var delta = Qt.point(mouse.x - clickPos.x,mouse.y - clickPos.y)
                        dialog_root.setX(dialog_root.x + delta.x)
                        dialog_root.setY(dialog_root.y + delta.y)
                    }
                }

                //关闭按钮
                MouseArea {
                    id: btnClose
                    Layout.fillHeight: parent
                    implicitWidth: 45

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                    }
                    onClicked: {
                        console.log("close button clicked.")

                        dialog_root.visible = false
                        Qt.quit()
                    }
                }
            }
        }

        //内容区域
        Rectangle {
            id: contentView
            Layout.fillWidth: parent
            Layout.fillHeight: parent
            color: "lightgray"

            Text {
                id: content
                anchors.centerIn: parent
            }
        }

        //按钮栏
        Rectangle {
            id: buttonBar
            Layout.fillWidth: parent
            implicitHeight: 30
            color: "darkgray"

            //添加YES和NO按钮
            RowLayout {
                anchors.fill: parent
                spacing: 2

                //h spacer
                Rectangle {
                    id: btnBarSpacer
                    color: Qt.rgba(0,0,0,0)
                    Layout.fillWidth: parent
                }

                //YES button
                MouseArea {
                    id: btnYes
                    Layout.fillHeight: parent
                    width: 75

                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                    }
                    Text {
                        text: btnYesString
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        console.log("yes button clicked.")
                        dialog_root.visible = false

                        accept()
                    }
                }

                //NO button
                MouseArea {
                    id: btnNo
                    Layout.fillHeight: parent
                    width: 75
                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                    }
                    Text {
                        text: btnNoString
                    }

                    onClicked: {
                        console.log("no button clicked.")

                        reject()
                    }
                }
            }
        }
    }
}

