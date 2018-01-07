import QtQuick 2.4


Item {
    id: name
    width: 600
    height: 600

    Rectangle{
        id:xiaohuang
        height: 80
        width: 80
        color: "yellow"
        radius: 5
        anchors.centerIn: parent //锚定位在父项的中间
        //anchors.fill: parent  //填充满父项，
        Text {
            anchors.centerIn: parent
            font.pixelSize: 30
            text: qsTr("小黄")
        }
    }
    Rectangle{
        id:xiaohong
        height: 80
        width: 80
        color: "red"
        radius: 5
        anchors.right: xiaohuang.left //本项的右边对齐于 xiaohuang的左边,
        anchors.rightMargin: 50 //右边缘的距离，距离为0时可以理解成边缘线公用
        //上面两条语句相当决定xiaohong的X左边
        //注意的是同时使用x，y坐标和锚布局，x，y坐标布局失效，有限与锚布局
        anchors.verticalCenter:  xiaohuang.verticalCenter //垂直线中心的定位
        anchors.verticalCenterOffset: 0 //垂直线中心的偏移
        //上面两句代码相当决定于Y坐标
        Text {
            anchors.centerIn: parent
            font.pixelSize: 30
            text: qsTr("小红")
        }
    }

    Rectangle{
        id:xiaolv
        height: 80
        width: 80
        color: "green"
        radius: 5
        anchors.left: xiaohuang.right
        anchors.leftMargin: 50
        //anchors.margins: 20 //所有进行边缘对齐的偏移量,优先级比上行低
        anchors.verticalCenter:  xiaohuang.verticalCenter
        anchors.verticalCenterOffset: 0
        Text {
            anchors.centerIn: parent
            font.pixelSize: 30
            text: qsTr("小绿")
        }
    }

    Rectangle{
        id:xiaoqing
        height: 80
        width: 80
        color: "cyan"
        radius: 5
        anchors.bottom: xiaohuang.top //本项的低端与xiaohuang和小黄的顶端对齐
        anchors.bottomMargin: 50
        //上面两行决定了Y坐标
        anchors.horizontalCenter: xiaohuang.horizontalCenter//水平线中心的定位
        anchors.horizontalCenterOffset: 0 //水平中心的偏移量
        //上面两行代码决定了X坐标的值
        Text {
            anchors.centerIn: parent
            font.pixelSize: 30
            text: qsTr("小青")
        }
    }

    Rectangle{
        id:xiaolan
        height: 80
        width: 80
        color: "blue"
        radius: 5
        anchors.top: xiaohuang.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: xiaohuang.horizontalCenter
        anchors.horizontalCenterOffset: 0
        Text {
            //anchors.centerIn: parent
            anchors.baseline: parent.baseline //底线等于（对齐）父的顶线
            anchors.baselineOffset: 20 //偏移量
            font.pixelSize: 30
            text: qsTr("小蓝")
            color: "red"
        }
    }
}
