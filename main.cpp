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

//    SocketToQML socketToQML;
    Client client;
    client.Init();

    QQmlContext* ctx = engine.rootContext();
//    ctx->setContextProperty("socketToQML", &socketToQML);
    ctx->setContextProperty("client", &client);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    socketToQML.setRotation(180);

    return app.exec();
}
