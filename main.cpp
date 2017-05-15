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

    Client client;
    client.Init("10.1.18.16");
    client.sendMessage(QString("GO"));
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("client", &client);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
