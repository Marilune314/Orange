// Written by WXR HJX YJY
// date 2025-7-9
// localplayer.h of the Screen Recorder application
#pragma once

#include <QQmlEngine>
#include <QProcess>
#include <QtQml/qqmlregistration.h>
class LocalPlayer : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit LocalPlayer(QObject *parent = nullptr);
    Q_INVOKABLE void startPlay(const QString &program, const QString &arguments);

signals:
    void stateChanged(int state);

private:
    QProcess *m_process;
};
