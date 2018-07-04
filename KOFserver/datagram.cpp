#include "datagram.h"

DataGram::DataGram()
{}

bool operator ==(const socketaddr &a, const socketaddr &b)
{
    return (a.sin_addr.s_addr == b.sin_addr.s_addr) && (a.sin_port == b.sin_port);
}
