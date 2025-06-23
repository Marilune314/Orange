#include "recorder.h"
#include <QFile>
Recorder::Recorder(QObject *parent) : QObject(parent), m_process(nullptr), m_partIndex(0) {}

void Recorder::startRecording(QString id)
{
    m_process = new QProcess(this);
    QString filename = QString("/root/part%1.mp4").arg(m_partIndex++);
    m_parts << filename;
    qDebug() << filename;

    QStringList args;
    qDebug() << "recorder:" << id;
    if (id == "-1") {
        args << "-y" << "-video_size" << "1920x1080" << "-framerate" << "30" << "-f" << "x11grab" << "-i" << ":0.0"
             << "-f" << "pulse" << "-i" << "default" << filename;
    } else {
        args << "-y" << "-f" << "x11grab" << "-window_id" << id << "-framerate" << "60" << "-i" << ":0.0"

             << "-f" << "pulse" << "-i" << "default" << filename;
    }

    m_process->start("ffmpeg", args);
}

void Recorder::pauseRecording()
{
    if (m_process) {
        m_process->terminate();
        m_process->waitForFinished();
        delete m_process;
        m_process = nullptr;
    }
}

void Recorder::resumeRecording(QString id)
{
    startRecording(id);
}

void Recorder::stopRecording(const QString &finalPath)
{
    pauseRecording();
    QProcess mergeProcess;
    qDebug() << "m_partIndex" << m_partIndex;
    if (m_partIndex > 1) {
        QFile file("file.txt");
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&file);
            for (const QString &part : m_parts)
                out << "file '" << part << "'\n";

            mergeProcess.start("ffmpeg", {"-f", "concat", "-safe", "0", "-i", "file.txt", "-c", "copy", finalPath});
            qDebug() << "拼接完成";
        }
    } else {
        mergeProcess.start("ffmpeg", {"-i", "/root/part0.mp4", "-c", "copy", finalPath});
        qDebug() << "只有一个 重命名成功";
    }
    m_partIndex = 0;
    mergeProcess.waitForFinished();
}
