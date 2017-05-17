#include <QTimer>
#include <QString>
#include <QTime>
#include <QDebug>
#include "digitalclock.h"

DigitalClock::DigitalClock()

{
    timer = new QTimer(this);
    time = new QTime(0,0,0);
    connect(timer, SIGNAL(timeout()), this, SLOT(showTime()));

}

void DigitalClock::init(){

    timer->start(1000);

    showTime();

}

void DigitalClock::showTime()
{

    *time = time->addSecs(1);
    QString text = time->toString("mm:ss");
    if ((time->second() % 2) == 0)
        text[2] = ' ';
      qInfo()<<text;
//    display(text);
}
