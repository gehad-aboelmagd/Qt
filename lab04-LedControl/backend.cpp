#include "backend.h"
#include <QDebug>

BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{}

void BackEnd::turnLedOn()
{
    qDebug() << "turnLedOn() was called...";
}

void BackEnd::turnLedOff()
{
    qDebug() << "turnLedOff() was called...";
}
