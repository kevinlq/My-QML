import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true;
    width: 400;
    height: 210;
    color: "#FFFFFF";
    title: qsTr("Login_demo");


    Text {
        id: text_name;
        x: 47;
        y: 35;
        text: qsTr("user name:");
        width: 80;
        height: 30;

        horizontalAlignment: Text.AlignVCenter;
        verticalAlignment: Text.AlignVCenter;

        font.pixelSize: 16;
    }

    TextField {
        id:textFiledName;
        x: 137;
        y: 35;
        width: 200;
        height: 30;
        placeholderText: qsTr("please input user name");
    }

    Text {
        id: text_pwd;
        x: 47  ;
        y: 85  ;
        text: qsTr("pwd:");
        width: 80;
        height: 30;
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignVCenter;

        font.pixelSize: 16;
    }

    TextField {
        id: textFiledPwd;
        x: 137;
        y: 85;
        width: 200;
        height: 30;
        echoMode: TextInput.Password;
        placeholderText: qsTr("please input pwd");
    }


    Button {
        id: btnLogin;
        x: 71;
        y: 145;
        width: 116;
        height: 36;
        text: qsTr("Login");
    }

    Button {
        id: btnCancel;
        x: 224;
        y: 145;
        width: 110;
        height: 36;
        text: qsTr("Cancel");
    }
}
