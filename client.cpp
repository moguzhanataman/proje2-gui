
#include <QTcpSocket>

/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/


#include <QtNetwork>
#include <QTcpSocket>
#include "client.h"

Client::Client(){}

void Client::init(QString dom)
{
    tcpSocket = new QTcpSocket(this);
    networkSession = Q_NULLPTR;
    currentDomain = dom;
    in.setDevice(tcpSocket);
    in.setVersion(QDataStream::Qt_4_0);

    connect(tcpSocket, &QIODevice::readyRead, this, &Client::readMessage);
    typedef void (QAbstractSocket::*QAbstractSocketErrorSignal)(QAbstractSocket::SocketError);
    connect(tcpSocket, static_cast<QAbstractSocketErrorSignal>(&QAbstractSocket::error),
            this, &Client::displayError);


    QNetworkConfigurationManager manager;
    if (manager.capabilities() & QNetworkConfigurationManager::NetworkSessionRequired) {
        // Get saved network configuration
        QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
        settings.beginGroup(QLatin1String("QtNetwork"));
        const QString id = settings.value(QLatin1String("DefaultNetworkConfiguration")).toString();
        settings.endGroup();

        // If the saved network configuration is not currently discovered use the system default
        QNetworkConfiguration config = manager.configurationFromIdentifier(id);
        if ((config.state() & QNetworkConfiguration::Discovered) !=
            QNetworkConfiguration::Discovered) {
            config = manager.defaultConfiguration();
        }

        networkSession = new QNetworkSession(config, this);
        connect(networkSession, &QNetworkSession::opened, this, &Client::sessionOpened);

        networkSession->open();

    }   
    requestNewMessage();

}

void Client::requestNewMessage()
{
    tcpSocket->abort();
    tcpSocket->connectToHost(currentDomain,8888);
}

void Client::readMessage()
{
    if(tcpSocket->bytesAvailable()){
        QByteArray arr = tcpSocket->readAll();
        currentMessage = QString(arr.data());

        qInfo() << "currentMsg = " << currentMessage;

        if (currentMessage == QString("Welcome")) {
            // Do nothing
        } else if (currentMessage == QString("quit") ) {
            tcpSocket->close();
            emit this->stopTimer();
            qInfo() << "quit received";
        } else if (currentMessage == QString("notfound")) {
            tcpSocket->close();
            emit this->stopTimer();
            qInfo() << "notfound received";
        } else if (currentMessage == QString("start")) {
            emit this->startTimer();
            qInfo() << "start received";
        } else {
            // Parse message

            // Camera X-y haric digerleri cin ali bulunmadiysa -1 gelebilir.
            int cam_x, cam_y;
            int cinali_x, cinali_y;
            int height, width;
            int angle;
//            int pos_x, pos_y;
            sscanf(currentMessage.toStdString().c_str(),
                   "%d %d %d %d %d %d %d",
                   &cam_x, &cam_y, &cinali_x, &cinali_y, &height, &width, &angle);

            qInfo() << "Message from server: " << currentMessage;
            qInfo() << "Parsed data: " << endl << "Kamera X: " << cam_x << " Kamera Y: " << cam_y
                    << endl << "Cinali X: " << cinali_x << " Cinali Y: " << cinali_y
                    << endl << "height: " << height << " width" << width << " angle " << angle << endl
                    << "=========================" << endl;
//            qInfo() << "pos_x: " << pos_x << " pos_y: " << pos_y;

            bool isCinAli = (cinali_x > 0) && (cinali_y > 0) && (height > 0) && (width > 0) && (angle > 0);

            if (isCinAli) {
                emit this->setPosX((int) ((cam_x - 28) + cinali_x * (56.0/640)));
                emit this->setPosY((int) ((cam_y - 21) + cinali_y * (42.0/480)));
                emit this->setRotation(angle);
                emit this->setHeight((int) height/480.0 * (42.0/480));
                emit this->setWidth((int) width/640.0 * (56.0/640));

                emit this->stickManFound();
            } else {
                emit this->setPosX(cam_x);
                emit this->setPosY(cam_y);
            }


            /*
            if (cam_x > 0 && cinali_x > 0) {

                emit this->setPosX((int) ((cam_x - 28) + cinali_x * (56.0/640)));
            }

            if (cam_y > 0 && cinali_y > 0) {
                emit this->setPosY((int) ((cam_y - 21) + cinali_y * (42.0/480)));
            }

            if (angle > 0) {
                emit this->setRotation(angle);
            }

            if (height > 0) {
                emit this->setHeight((int) height/480.0 * (42.0/480));
            }

            if (width > 0) {
                emit this->setWidth((int) width/640.0 * (56.0/640));
            }*/
        }
    }
}

void Client::sendMessage(QString messageToSend)
{
    tcpSocket->write(messageToSend.toStdString().c_str(), messageToSend.size());
}

void Client::displayError(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::RemoteHostClosedError:
        break;
    case QAbstractSocket::HostNotFoundError:

        qInfo() << "The host was not found. Please check the host name and port settings.";
        break;
    case QAbstractSocket::ConnectionRefusedError:
      qInfo() << "The connection was refused by the peer. Make sure the fortune server is running,"<<
                 " and check that the host name and port settings are correct.";
        break;
    default:
       qInfo() << "The following error occurred: " + tcpSocket->errorString();
    }

}

void Client::sessionOpened()
{
    // Save the used configuration
    QNetworkConfiguration config = networkSession->configuration();
    QString id;
    if (config.type() == QNetworkConfiguration::UserChoice)
        id = networkSession->sessionProperty(QLatin1String("UserChoiceConfiguration")).toString();
    else
        id = config.identifier();

    QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
    settings.beginGroup(QLatin1String("QtNetwork"));
    settings.setValue(QLatin1String("DefaultNetworkConfiguration"), id);
    settings.endGroup();

//    statusLabel->setText(tr("This examples requires that you run the "
//                            "Fortune Server example as well."));


}

void Client::sendPause() {
    sendMessage(QString("pause"));
}

void Client::sendContinue() {
    sendMessage(QString("continue"));
}

void Client::sendQuit() {
    sendMessage(QString("quit"));
    tcpSocket->close();
}

void Client::sendStart(int algorithm) {
    sendMessage(QString::number(algorithm));
}

void Client::setIpAddr(QString ipAddr) {
    currentDomain = ipAddr;
}

void Client::initClock() {
    clock.init();
}
