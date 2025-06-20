#pragma once

#include <QObject>
#include <QQmlEngine>
class FileHelper : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit FileHelper(QObject *parent = nullptr);
    Q_INVOKABLE bool ensureDirExists(const QString &path);
signals:
};
