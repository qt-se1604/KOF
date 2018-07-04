#ifndef SOCKET_H
#define SOCKET_H

#include <QObject>
#include <QUdpSocket>
#include "jsonanalysis.hpp"

class UdpSocket : public QObject {
    Q_OBJECT
    Q_ENUMS(SocketState)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    enum class SocketState {
        Unconnected, Connected, Other
    };

    explicit UdpSocket(QObject *parent = nullptr);
    ~UdpSocket();

    QString url() const;
    void setUrl(QString newUrl);

    Q_INVOKABLE void sendState(QString key, double value);
    Q_INVOKABLE void sendState(QString key, bool value);

signals:
    void urlChanged();
    void stateChanged(SocketState currentState);

    void xChanged(double xValue);
    void yChanged(double yValue);
    void fireChanged(bool isFire);
    void timeChanged(double time);
    void musicChanged(double music);
    void backgroundChanged(double background);
    void findgameChanged(bool findgame);
    void jumpChanged(bool jump);

public slots:
    void receiveMessage();
    void socketState(QAbstractSocket::SocketState currentState);

private:
    QUdpSocket *m_udpSocket;
    QString m_hostAddress;
    int m_port;

    JsonAnalysis json;
};

#endif // SOCKET_H
