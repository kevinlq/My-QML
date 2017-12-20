#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QResource>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
<<<<<<< HEAD
//    QString strRccPath = QGuiApplication::applicationDirPath ()+"/qml.rcc";
    QString strRccPath = "qml.rcc";
=======
    QString strRccPath = QGuiApplication::applicationDirPath ()+"/qml.skin";
>>>>>>> temp
    qDebug()<<"strRccPath:"<<strRccPath;

    //    QByteArray baRcc = strRccPath.toLatin1 ();

    QString strRoot = "";
//    QResource::unregisterResource (strRccPath);

    if (QResource::registerResource (strRccPath,strRoot) )
    {
        qDebug()<<"register rcc ok!";
    }else
    {
        QResource::unregisterResource (strRccPath);
        qDebug()<<"register rcc error!";
<<<<<<< HEAD
        //        return 0;
=======
        return 0;
>>>>>>> temp
    }


    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:///main.qml"));

    return app.exec();
}
