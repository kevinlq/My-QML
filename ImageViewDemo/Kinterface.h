#ifndef KINTERFACE_H
#define KINTERFACE_H

#include <QObject>

class KInterface : public QObject
{
    Q_OBJECT
public:
    explicit KInterface(QObject *parent = nullptr);

public slots:
    bool openFolder(const QString &strPath);
};

#endif // KINTERFACE_H
