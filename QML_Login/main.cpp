#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QStringList strFileList;
    strFileList.append ("main");
    strFileList.append ("QLogin");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QString("qrc:/%1.qml").arg (strFileList.at (1))));

    return app.exec();
}
