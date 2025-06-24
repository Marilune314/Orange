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
        // args << "-y" << "-video_size" << "1920x1200" << "-framerate" << "300" << "-f" << "x11grab"
        //      << "-i" << ":0.0"
        //      << "-f" << "pulse" << "-i" << "default" << filename;

        args << "-y" << "-video_size" << "1920x1200" << "-framerate" << "30" << "-f" << "x11grab"
             << "-i" << ":0.0"
             << "-f" << "pulse" << "-i" << "default" << "-vcodec" << "mpeg4" << "-q:v" << "5"
             << filename;
    } else {
        args << "-y" << "-f" << "x11grab" << "-window_id" << id << "-framerate" << "60" << "-i"
             << ":0.0"

             << "-f" << "pulse" << "-i" << "default" << "-vcodec" << "mpeg4" << "-q:v" << "5"
             << filename;
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
    //
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

            mergeProcess
                .start("ffmpeg",
                       {"-f", "concat", "-safe", "0", "-i", "file.txt", "-c", "copy", mOutput});
            qDebug() << "拼接完成";
        }
    } else {
        mergeProcess.start("ffmpeg", {"-i", "/root/part0.mp4", "-c", "copy", mOutput});
        qDebug() << "只有一个 重命名成功";
    }

    m_partIndex = 0;
    mergeProcess.waitForFinished();
    if (isGif) {
        QProcess convertProcess;
        convertProcess.start("ffmpeg",
                             {"-i",
                              mOutput,
                              //"-ss", "00:00:01.000",  // 选裁剪开始时间
                              //"-t",
                              //"12", // 选持续时长
                              //"-vf",
                              //"scale=480:-1", // 缩放宽度为 480，高度按比例
                              //"-r",
                              //"15", // gif 帧率
                              "-q:v",
                              "5",
                              finalPath});
        convertProcess.waitForFinished();
        qDebug() << "convert gif succ";
    }
}
