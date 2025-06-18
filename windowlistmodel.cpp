#include "windowlistmodel.h"
#include <QWindowCapture>

WindowListModel::WindowListModel(QObject *parent)
    : QAbstractListModel(parent)
    , windowList(QWindowCapture::capturableWindows())
{}

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
    }
    return QVariant();
}

QHash<int, QByteArray> WindowListModel::roleNames() const
{
    return {{Qt::DisplayRole, "display"}};
}

QCapturableWindow WindowListModel::getWindow(int index)
{
    return windowList.at(index);
}
void WindowListModel::populate()
{
    beginResetModel();
    windowList = QWindowCapture::capturableWindows();
    endResetModel();
}
