#pragma once

#include <QQmlEngine>
#include <QAbstractItemModel>
#include <QCapturableWindow>
#include <QtQml/qqmlregistration.h>
class WindowListModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    WindowListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE QCapturableWindow getWindow(int index);
    Q_INVOKABLE void populate();

private:
    QList<QCapturableWindow> windowList;
};
