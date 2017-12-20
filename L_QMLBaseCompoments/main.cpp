#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QResource>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
//    QString strRccPath = QGuiApplication::applicationDirPath ()+"/qml.rcc";
    QString strRccPath = "qml.rcc";
    qDebug()<<"strRccPath:"<<strRccPath;

    //    QByteArray baRcc = strRccPath.toLatin1 ();

    QString strRoot = "";
    QResource::unregisterResource (strRccPath);

    if (QResource::registerResource (strRccPath,strRoot) )
    {
        qDebug()<<"register rcc ok!";
    }else
    {
        QResource::unregisterResource (strRccPath);
        qDebug()<<"register rcc error!";
        //        return 0;
    }


    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:///main.qml"));

    return app.exec();
}
