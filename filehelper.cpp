#include "filehelper.h"
#include <QDir>

FileHelper::FileHelper(QObject *parent) : QObject{parent} {}

bool FileHelper::ensureDirExists(const QString &path)
{
    QDir dir(path);
    qDebug() << path + " is existing:" << dir.exists();
    qDebug() << "Expected path:" << QDir::toNativeSeparators(path);
    if (!dir.exists()) { return dir.mkpath("."); }
    return true;
}
