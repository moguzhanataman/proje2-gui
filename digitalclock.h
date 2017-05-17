
#ifndef DIGITALCLOCK_H
#define DIGITALCLOCK_H

class DigitalClock : QObject
{
    Q_OBJECT

public:
    DigitalClock();
    QTime *time;
private slots:
    void showTime();
};

#endif
