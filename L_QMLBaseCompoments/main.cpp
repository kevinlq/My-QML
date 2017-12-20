#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QResource>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QString strRccPath = QGuiApplication::applicationDirPath ()+"/QmlResSkin.rcc";
    qDebug()<<"strRccPath:"<<strRccPath;

    QByteArray baRcc = strRccPath.toLatin1 ();

    QString strRoot = "";

    if (QResource::registerResource (baRcc.data (),strRoot) )
    {
        qDebug()<<"register rcc ok!";
    }else
    {
        QResource::unregisterResource (baRcc.data ());
        qDebug()<<"register rcc error!";
        return 0;
    }


    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/QmlRes/main.qml"));

    return app.exec();
}
