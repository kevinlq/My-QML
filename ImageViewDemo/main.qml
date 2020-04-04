import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import com.kevinlq.image 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("ImageViewDemo")

    //

    KInterface
    {
        id: kinterface;
    }

    DropArea
    {
        width: parent.width
        height: parent.height

        onEntered: {
            if (drag.urls.length !== 1)
            {
                drag.accepted = false;
                return false;
            }
        }

        onDropped: {
            if (drop.hasUrls)
            {
                // get first file
                var filePath = drop.urls[0];
                if (filePath.indexOf("file:///") === 0)
                {
                    filePath = filePath.replace("file:///", "");
                }

                kinterface.openFolder(filePath)

                mainView.imageEvent("redrawImage");
            }
        }
    }

    ImageMainView
    {
        id: mainView;
        width: parent.width
        height: parent.height
    }
}
