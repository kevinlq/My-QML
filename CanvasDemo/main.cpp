#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QQuickView view;
    view.setResizeMode (QQuickView::SizeRootObjectToView);
    view.setSource (QUrl("qrc:/main.qml"));
    view.setMaximumSize (QSize(600,600));
    view.setTitle ("FishDemo");
    view.show ();

    return app.exec();
}
