#ifndef PLAYER_H
#define PLAYER_H

#include "datagram.h"
#include <memory>

#define REST_TIME_TO_LIVE 1000

class Room;

class Player : public std::enable_shared_from_this<Player> {
public:
	Player(int id, socketaddr addr);

    bool isRoomOwner();
    bool myRoomIsNotFull();
	void createRoom(int roomId);
    bool joinInRoom(std::weak_ptr<Room> stay);
    std::weak_ptr<Room> myRoom();

	int id() const;
    int updateTimeToLive(bool isRecivedDataFromThis);
    bool matchesMyAddr(socketaddr addr);
    void exitTheGame();

    void sendToMe(transimissionMessage message);
    void messageToMyRoom(transimissionMessage &message);

private:
	int m_id;
    std::shared_ptr<Room> _belongToRoom;
    socketaddr m_addr;
    int m_timeToLive;
};

#endif // PLAYER_H
