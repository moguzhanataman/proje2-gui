
#ifndef DIGITALCLOCK_H
#define DIGITALCLOCK_H

#include <QObject>
#include <QTimer>

class DigitalClock : QObject
{
    Q_OBJECT

public:
    DigitalClock();
    QTime *time;
    QTimer *timer;
    QString text;

public slots:
    void updateTime();
    QString getTime();
    void init();

signals:
    void clockTick(QString currentClock);
};

#endif
