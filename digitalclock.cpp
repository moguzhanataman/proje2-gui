#include <QTimer>
#include <QString>
#include <QTime>
#include <QDebug>
#include "digitalclock.h"

DigitalClock::DigitalClock()

{
    timer = new QTimer(this);
    time = new QTime(0,0,0);
    connect(timer, SIGNAL(timeout()), this, SLOT(updateTime()));

}

void DigitalClock::init(){
    timer->start(1000);
}

QString DigitalClock::getTime() {
    return text;
}

void DigitalClock::updateTime()
{
    *time = time->addSecs(1);
    text = time->toString("mm:ss");
    if ((time->second() % 2) == 0) {
        text[2] = ' ';
    }
    qInfo()<<text;
//    display(text);
}
