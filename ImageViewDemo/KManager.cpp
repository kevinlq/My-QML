/**
* Copyright (C), kevinlq,All rights reserved.
* @file
* @brief
* @author
* @email
* @version
* @date 2020.04.04
* @note QQ: 2313828706
* @warning
* @todo
* @history:
*/
#include "KManager.h"

// Qt lib
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QPainter>
#include <QImage>

// custom lib
#include "KImageView.h"
#include "Kinterface.h"

KManager *KManager::getInstance()
{
    static KManager _instance;
    return &_instance;
}

KManager::KManager()
    : m_pImage(Q_NULLPTR)
{
}

KManager::~KManager()
{
    if (m_pImage)
    {
        delete m_pImage;
        m_pImage = Q_NULLPTR;
    }
}

int KManager::startManager(int argc, char **argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    registerType();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

bool KManager::openFolder(const QString &strPath)
{
    if (strPath.isEmpty())
    {
        return false;
    }

    if (m_pImage != Q_NULLPTR)
    {
        delete m_pImage;
        m_pImage = Q_NULLPTR;
    }

    qDebug () <<" filePath:" << strPath;

    m_pImage = new QImage(strPath);

    return true;
}

void KManager::drawImage(QPainter *pPainter, const QRect &rect)
{
    if (pPainter == Q_NULLPTR || rect.isEmpty())
    {
        return;
    }

    if (m_pImage == Q_NULLPTR)
    {
        return;
    }

    pPainter->setRenderHint(QPainter::Antialiasing, true);
    pPainter->setRenderHint(QPainter::HighQualityAntialiasing, true);
    pPainter->setRenderHint(QPainter::SmoothPixmapTransform, true );

    pPainter->drawImage(rect, *m_pImage);
}

void KManager::registerType()
{
    int versionMajor = 1;
    int versionMinor = 0;

    qmlRegisterType<KImageView>("com.kevinlq.image",versionMajor,versionMinor,"KImageView");
    qmlRegisterType<KInterface>("com.kevinlq.image",versionMajor,versionMinor,"KInterface");
}
