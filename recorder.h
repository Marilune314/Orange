// Written by WXR HJX YJY
// date 2025-7-9
// recorder.h of the Screen Recorder application
#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QProcess>
class Recorder : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Recorder(QObject *parent = nullptr);
    Q_INVOKABLE void startRecording(QString id);

    Q_INVOKABLE void pauseRecording();
    Q_INVOKABLE void resumeRecording(QString id);
    Q_INVOKABLE void stopRecording(const QString &finalPath);
    // void generateFile();
    Q_INVOKABLE QString getVideoSize();
    Q_INVOKABLE void setVideoSize(const QString &size);

private:
    QProcess *m_process;
    QStringList m_parts;
    int m_partIndex;
    QString m_setVideoSize;
};
