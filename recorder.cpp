#include "recorder.h"
#include <QFile>
Recorder::Recorder(QObject *parent) : QObject(parent), m_process(nullptr), m_partIndex(0) {}

void Recorder::startRecording(QString id)
{
    m_process = new QProcess(this);

    QString filename = QString("part%1.mp4").arg(m_partIndex++);
    m_parts << filename;
    qDebug() << filename;
    //ffmpeg -f x11grab -framerate 30 -video_size $(xdpyinfo | grep 'dimensions:' | awk '{print $2}') -i :0.0  -vf "hqdn3d=1.5:1.5:6:6"   /root/2560x1600.mp4
    QStringList args;
    qDebug() << "recorder:" << id;
    if (id == "-1") {
        args << "-y" << "-video_size" << "1920x1200" << "-framerate" << "30" << "-f" << "x11grab" << "-i" << ":0.0"
             << "-f" << "pulse" << "-i" << "default" << "-vcodec" << "mpeg4" << "-q:v" << "1" << filename;
    } else {
        args << "-y" << "-f" << "x11grab" << "-window_id" << id << "-framerate" << "60" << "-i" << ":0.0"

             << "-f" << "pulse" << "-i" << "default" << "-q:v" << "5" << filename;
    }

    m_process->start("/usr/bin/ffmpeg", args);
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
    QString mOutput = finalPath;
    bool isGif = finalPath.endsWith(".gif", Qt::CaseInsensitive);
    if (isGif) {
        mOutput = finalPath.left(finalPath.lastIndexOf(".")) + ".mp4"; //last:最后一次出现
    }

    if (m_partIndex > 1) {
        QFile file("file.txt");
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&file);
            for (const QString &part : m_parts)
                out << "file '" << part << "'\n";

            mergeProcess.start("ffmpeg", {"-f", "concat", "-safe", "0", "-i", "file.txt", "-c", "copy", mOutput});
            qDebug() << "拼接完成";
        }
    } else {
        mergeProcess.start("ffmpeg", {"-i", "part0.mp4", "-c", "copy", finalPath});
        qDebug() << "只有一个 重命名成功";
    }

    mergeProcess.waitForFinished();

    if (isGif) {
        QProcess convertProcess;
        convertProcess.start("ffmpeg", {"-i", mOutput, "-q:v", "5", finalPath});
        convertProcess.waitForFinished();
        qDebug() << "convert gif succ";
    }

    if (QFile::remove("file.txt") != 0) qDebug() << "file.txt remove successfully!";
    for (int i = 0; i < m_partIndex; i++) {
        QString partFile = QString("part%1.mp4").arg(i);
        if (QFile::remove(partFile))
            qDebug() << "Removed:" << partFile;
        else
            qWarning() << "Failed to remove:" << partFile;
    }

    m_partIndex = 0;
}
