#ifndef KMANAGER_H
#define KMANAGER_H

// Qt lib
#include <QObject>
class QPainter;
class QImage;

typedef QVector<QImage*> VTRP_IMAGE;

class KManager
{
private:
    KManager();
    ~KManager();

public:
    static KManager* getInstance();

    int startManager(int argc, char **argv);

    bool openFolder(const QString &strPath);

    void drawImage(QPainter *pPainter, const QRect &rect);

private:
    void registerType();

    QImage  *m_pImage;
};

#endif // KMANAGER_H
