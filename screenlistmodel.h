#pragma once

#include <QQmlEngine>
#include <QAbstractListModel>
#include <QScreen>
#include <QtQml/qqmlregistration.h>

class ScreenListModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    ScreenListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE QScreen *screen(int index);
private slots:
    void screenChanged();
};
