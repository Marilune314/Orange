// Written by WXR HJX YJY
// date 2025-7-9
// localplayer.cpp of the Screen Recorder application
#include "localplayer.h"

LocalPlayer::LocalPlayer(QObject *parent) : QObject(parent), m_process(new QProcess(this)) {}
void LocalPlayer::startPlay(const QString &program, const QString &arguments)
{
    m_process->start(program, QStringList() << arguments);
}
