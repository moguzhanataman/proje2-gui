#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtDebug>
#include <QThread>
#include <QObject>
#include "sockettoqml.h"
#include "client.h"
#include "digitalclock.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SocketToQML socketToQML;
    Client client;
    client.Init("192.168.1.37");
    DigitalClock digiClock;
    digiClock.init();
    client.sendMessage(QString("GO"));
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("client", &client);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    socketToQML.setRotation(180);

    return app.exec();
}
