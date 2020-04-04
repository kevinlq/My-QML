#include "KInterface.h"
#include "KManager.h"

KInterface::KInterface(QObject *parent) : QObject(parent)
{
}

bool KInterface::openFolder(const QString &strPath)
{
    return KManager::getInstance()->openFolder(strPath);
}
