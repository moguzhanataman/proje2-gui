#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtDebug>
#include <QThread>
#include <QObject>
#include "sockettoqml.h"
#include "client.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qDebug() << "hello1" << endl;
    Client client;
//    DigitalClock clock;
    qDebug() << "hello2" << endl;
//    client.Init("192.168.43.246");
//    client.Init("10.1.18.126");
//    client.sendMessage(QString("1"));
    qDebug() << "hello3" << endl;
    QQmlContext* ctx = engine.rootContext();
    qDebug() << "hello4" << endl;
    ctx->setContextProperty("client", &client);
//    ctx->setContextProperty("clock", &clock);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
