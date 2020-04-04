import QtQuick 2.0

import com.kevinlq.image 1.0

Item {
    id: mainVeiw

    signal imageEvent(string params)

    Rectangle{
        id: bourde;
        anchors.centerIn: parent
        width: parent.width - 10
        height: parent.height - 10
        border.color: "#7C7B7B"
    }

    KImageView
    {
        id: _imageView
        nViewId: 0
        width: parent.width
        height: parent.height
    }

    onImageEvent: {
        if (params === "redrawImage")
        {
            _imageView.signalRedraw();
        }
    }
}
