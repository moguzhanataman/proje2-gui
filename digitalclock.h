
#ifndef DIGITALCLOCK_H
#define DIGITALCLOCK_H

#include <QObject>
#include <QTimer>

class DigitalClock : QObject
{
    Q_OBJECT

public:
    DigitalClock();
    void init();
    QTime *time;
    QTimer *timer;
private slots:
    void showTime();
};

#endif
