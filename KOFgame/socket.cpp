#include "socket.h"
#include <QString>
#include <QDebug>
#include <QNetworkDatagram>
#include "jsonanalysis.hpp"
#include <cmath>

UdpSocket::UdpSocket(QObject *parent)
    : QObject(parent)
{
    m_udpSocket = new QUdpSocket(this);
    m_udpSocket->bind(m_udpSocket->localAddress(), m_udpSocket->localPort());

    connect(m_udpSocket, &QUdpSocket::readyRead, this, &UdpSocket::receiveMessage);
    connect(m_udpSocket, QOverload<QAbstractSocket::SocketState>::of(&QAbstractSocket::stateChanged),
            this, &UdpSocket::socketState);

    connect(&json, &JsonAnalysis::xChanged, this, &UdpSocket::xChanged);
    connect(&json, &JsonAnalysis::yChanged, this, &UdpSocket::yChanged);
    connect(&json, &JsonAnalysis::fireChanged, this, &UdpSocket::fireChanged);
    connect(&json, &JsonAnalysis::timeChanged, this, &UdpSocket::timeChanged);
    connect(&json, &JsonAnalysis::musicChanged, this, &UdpSocket::musicChanged);
    connect(&json, &JsonAnalysis::backgroundChanged, this, &UdpSocket::backgroundChanged);
    connect(&json, &JsonAnalysis::findgameChanged, this, &UdpSocket::findgameChanged);
    connect(&json, &JsonAnalysis::jumpChanged, this, &UdpSocket::jumpChanged);
	connect(&json, &JsonAnalysis::quitRoomChanged, this, &UdpSocket::quitRoomChanged);
    connect(&json, &JsonAnalysis::closeattackChanged, this, &UdpSocket::closeattackChanged);
}

UdpSocket::~UdpSocket()
{
    delete m_udpSocket;
}

QString UdpSocket::url() const
{
    return m_hostAddress + QString::number(m_port);
}

void UdpSocket::setUrl(QString newUrl)
{
    QStringList tmp = newUrl.split(":");
    auto it = tmp.begin();
    if(m_hostAddress != *it && m_port != *(it + 1))
    {
        m_hostAddress = *it;
        m_port = (*(it + 1)).toInt();
        emit urlChanged();
    }
}

void UdpSocket::sendState(QString key, double value)
{
    QByteArray byteArray =  json.makeJson(key, round(value));
    m_udpSocket->writeDatagram(byteArray, QHostAddress(m_hostAddress), static_cast<quint16>(m_port));
}

void UdpSocket::sendState(QString key, bool value)
{
    QByteArray byteArray =  json.makeJson(key, value);
    m_udpSocket->writeDatagram(byteArray, QHostAddress(m_hostAddress), static_cast<quint16>(m_port));
}

void UdpSocket::receiveMessage()
{
    QByteArray jsonMsg;
    /*QByteArray message = m_udpSocket->readAll();
    auto end = std::find(message.begin(), message.end(), '\0');
    std::copy(message.begin(), end, std::back_inserter(jsonMsg));
    json.jsonAnalyze(jsonMsg);*/

    QByteArray message;
    message.resize(m_udpSocket->pendingDatagramSize());
    QHostAddress address = m_udpSocket->localAddress();
    quint16 port = m_udpSocket->localPort();
    m_udpSocket->readDatagram(message.data(), static_cast<qint64>(50), &address, &port);
    auto end = std::find(message.begin(), message.end(), '\0');
    std::copy(message.begin(), end, std::back_inserter(jsonMsg));
    json.jsonAnalyze(jsonMsg);
}

void UdpSocket::socketState(QAbstractSocket::SocketState currentState)
{
    switch(currentState)
    {
        case QAbstractSocket::UnconnectedState :
            emit stateChanged(SocketState::Unconnected);
            break;
        case QAbstractSocket::ConnectedState :
            emit stateChanged(SocketState::Connected);
            break;
        default:
            emit stateChanged(SocketState::Other);
            break;
    }
}
