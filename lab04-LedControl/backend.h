#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtQml>

class BackEnd : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BackEnd(QObject *parent = nullptr);
    Q_INVOKABLE void turnLedOn();
    Q_INVOKABLE void turnLedOff();
signals:
};

#endif // BACKEND_H
