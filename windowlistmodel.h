// Written by WXR HJX YJY
// date 2025-7-9
// windowlistmodel.h of the Screen Recorder application
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
    void generateFile();
    void readId();
    Q_INVOKABLE QCapturableWindow getWindow(int index);
    Q_INVOKABLE void populate();

    enum Roles {
        DisplayRole = Qt::DisplayRole,
        WindowIdRole = Qt::UserRole + 1 // 新增角色
    };
    Q_ENUM(Roles);

private:
    QList<QCapturableWindow> windowList;
    QList<int> windowId;
};
