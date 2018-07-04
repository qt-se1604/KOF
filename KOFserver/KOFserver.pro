TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

LIBS += -ljsoncpp

SOURCES += main.cpp \
    udpserver.cpp \
    onlineclients.cpp \
    datagram.cpp \
    player.cpp \
    room.cpp

HEADERS += \
    udpserver.h \
    onlineclients.h \
    datagram.h \
    player.h \
    room.h
