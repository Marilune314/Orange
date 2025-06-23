#include "windowlistmodel.h"
#include <QWindowCapture>
#include <iostream>
#include <QProcess>
#include <QFile>
WindowListModel::WindowListModel(QObject *parent)
    : QAbstractListModel(parent)
    , windowList(QWindowCapture::capturableWindows())
{
    generateFile();
    readId();
    // std::cout << "initialize \n";
}

int WindowListModel::rowCount(const QModelIndex &parent) const
{
    return windowList.size();
}

QVariant WindowListModel::data(const QModelIndex &index, int role) const
{
    Q_ASSERT(index.isValid());
    Q_ASSERT(index.row() <= windowList.size());
    if (role == Qt::DisplayRole) {
        auto window = windowList.at(index.row());
        return window.description();
    } else if (role == WindowIdRole) {
        return windowId[index.row()];
    }
    return QVariant();
}

QHash<int, QByteArray> WindowListModel::roleNames() const
{
    return {{Qt::DisplayRole, "display"}, {WindowIdRole, "windowId"}};
}

void WindowListModel::generateFile()
{
    QProcess p;
    // p.setWorkingDirectory("/root/Orange");
    p.start("bash",
            {"-c",
             "xprop -root _NET_CLIENT_LIST | awk -F'# ' '{gsub(/, */, \"\\n\", $2); print $2}' > ../../windowId.txt"});
    qDebug() << p.state();
    if (!p.waitForFinished()) {
        qDebug() << "Error:" << p.errorString();
        return;
    }
    qDebug() << "Generated successfully. Output saved to windowId.txt";
}

void WindowListModel::readId()
{
    bool ok;
    QFile file("../../windowId.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open file:" << file.errorString();
        return;
    }
    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        quint32 value = line.toUInt(&ok, 16); // 支持0x前缀
        if (ok) {
            windowId.append(value);
            qDebug() << "Parsed line:" << line << "->" << QString("0x%1").arg(value, 0, 16);
        } else {
            qWarning() << "Invalid hex at line" << ":" << line;
        }
    }
    file.close();
}

QCapturableWindow WindowListModel::getWindow(int index)
{
    return windowList.at(index);
}
void WindowListModel::populate()
{
    beginResetModel();
    windowList = QWindowCapture::capturableWindows();
    generateFile();
    readId();
    endResetModel();
}
