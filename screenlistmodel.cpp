#include "screenlistmodel.h"
#include <QGuiApplication>
#include <QTextStream>
#include <QScreen>
ScreenListModel::ScreenListModel(QObject *parent) : QAbstractListModel(parent)
{
    auto *app = qApp; //qApp 实际上是 QCoreApplication::instance() 的宏
    connect(app, &QGuiApplication::screenAdded, this, &ScreenListModel::screenChanged);
    connect(app, &QGuiApplication::screenRemoved, this, &ScreenListModel::screenChanged);
    connect(app, &QGuiApplication::primaryScreenChanged, this, &ScreenListModel::screenChanged);
}

QVariant ScreenListModel::data(const QModelIndex &index, int role) const
{
    auto screenList = QGuiApplication::screens();
    Q_ASSERT(index.isValid());
    Q_ASSERT(index.row() <= screenList.size());

    if (role == Qt::DisplayRole) {
        auto *screen = screenList.at(index.row());
        QString description;
        QTextStream str(&description);
        str << '"' << screen->name() << "\" " << screen->size().width() << 'x' << screen->size().height() << ","
            << screen->logicalDotsPerInch() << "DPI";
        return description;
    }
    return QVariant{};
}

QHash<int, QByteArray> ScreenListModel::roleNames() const
{
    return {{Qt::DisplayRole, "display"}};
}


void ScreenListModel::screenChanged()
{
    beginResetModel();
    endResetModel();
}

int ScreenListModel::rowCount(const QModelIndex &parent) const
{
    return QGuiApplication::screens().size();
}
