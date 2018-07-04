#ifndef DATAGRAM_H
#define DATAGRAM_H

#include <arpa/inet.h>
#include <unistd.h>
#include <array>

#define DATA_GRAM_SIZE 50
using socketaddr = sockaddr_in;
using transimissionMessage = std::array<char, DATA_GRAM_SIZE>;

class DataGram {
public:
    DataGram();

    socketaddr addr;
    transimissionMessage message;
};

bool operator ==(const socketaddr &a, const socketaddr &b);

#endif // DATAGRAM_H
