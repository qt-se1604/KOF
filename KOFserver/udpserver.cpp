#include "udpserver.h"
#include "datagram.h"
#include <iostream>

using std::cout;            using std::endl;

int UdpServer::m_fd = -1;

UdpServer *UdpServer::getServer()
{
    static UdpServer *m_server = new UdpServer();
    return m_server;
}

UdpServer::~UdpServer()
{
    close(m_fd);
}

UdpServer::UdpServer()
{
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(DEFAULT_PORT);
    addr.sin_addr.s_addr = inet_addr(DEFAULT_IP);

    m_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if(bind(m_fd, (struct sockaddr *)&addr, sizeof(addr)) == -1)
        throw std::runtime_error("Bind error");
    cout << "Initialized udp server" << endl;
}

DataGram UdpServer::readDataGram()
{
    DataGram data;
    socklen_t sockaddrSize = sizeof(sockaddr);
    data.message.fill(0);
    recvfrom(m_fd, data.message.data(), DATA_GRAM_SIZE, 0, (struct sockaddr *)&data.addr, &sockaddrSize);

    return data;
}

void UdpServer::writeDataGram(DataGram data)
{
    static constexpr socklen_t sockaddrSize = sizeof(sockaddr);
    sendto(m_fd, data.message.data(), DATA_GRAM_SIZE, 0, (struct sockaddr *)&data.addr, sockaddrSize);
}

UdpServer *operator <<(UdpServer *in, DataGram &data)
{
    in->writeDataGram(data);
    return in;
}

UdpServer *operator >>(UdpServer *out, DataGram &data)
{
    data = out->readDataGram();
    return out;
}
