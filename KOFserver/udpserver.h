#ifndef UDPSERVER_H
#define UDPSERVER_H

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/socket.h>
//#include <sys/epoll.h>
//#include <signal.h>
//#include <stdlib.h>
#include <array>

#define DEFAULT_IP "10.253.161.100"
#define DEFAULT_PORT 10000

class DataGram;

class UdpServer {
    friend UdpServer *operator <<(UdpServer *in, DataGram &data);
    friend UdpServer *operator >>(UdpServer *out, DataGram &data);

public:
    static UdpServer *getServer();

private:
    UdpServer();

    DataGram readDataGram();
    void writeDataGram(DataGram data);

    static int m_fd;
};

UdpServer *operator <<(UdpServer *in, DataGram &data);
UdpServer *operator >>(UdpServer *out, DataGram &data);

#endif // UDPSERVER_H
