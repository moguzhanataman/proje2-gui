#ifndef SOCKETTOQML_H
#define SOCKETTOQML_H

#include <QObject>

class SocketToQML : public QObject
{
    Q_OBJECT
public:
    explicit SocketToQML(QObject *parent = 0);

signals:
    void setRotation(int degree);
    void setShortSide(int length);
    void setLongSide(int length);

public slots:
};

#endif // SOCKETTOQML_H
