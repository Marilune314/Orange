#include "recorder.h"
#include <QFile>
Recorder::Recorder(QObject *parent) : QObject(parent), m_process(nullptr), m_partIndex(0) {}

void Recorder::startRecording(QString id)
{
    m_process = new QProcess(this);
    QString filename = QString("/root/part_60_%1.mkv").arg(m_partIndex++);
    m_parts << filename;
    qDebug() << filename;

    QStringList args;
    qDebug() << "recorder:" << id;
    if (id == "-1") {
        args << "-y" << "-video_size" << "2560x1600" << "-framerate" << "30" << "-f" << "x11grab" << "-i" << ":0.0"
             << "-f" << "pulse" << "-i" << "default" << filename;
    } else {
        args << "-y" << "-f" << "x11grab" << "-window_id" << id << "-framerate" << "30" << "-i" << ":0.0"

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

    // 拼接命令：生成 file.txt
    if (m_partIndex != 1) {
        QFile file("file.txt");
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&file);
            for (const QString &part : m_parts)
                out << "file '" << part << "'\n";
        }

        QProcess mergeProcess;
        mergeProcess.start("ffmpeg", {"-f", "concat", "-safe", "0", "-i", "file.txt", "-c", "copy", finalPath});
        qDebug() << "拼接完成";
        // if (QFile::remove("file.txt") == 0) qDebug() << "file.txt remove successfully!";
        // for (int i = 0; i < m_partIndex; i++) {
        //     if (QFile::remove("file.txt") == 0) qDebug() << "file.txt remove successfully!";
        // }
        mergeProcess.waitForFinished();
    }
}
