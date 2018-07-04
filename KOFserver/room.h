#ifndef ROOM_H
#define ROOM_H

#include "datagram.h"
#include <memory>
#include <list>

#define MAX_ROOM_MEMBER_NUMBER 2

class Player;

class Room {
public:
	Room(int id, std::weak_ptr<Player> isroomOwner);

    bool amITheRoomOwner(std::weak_ptr<Player> isRoomOwner);
    bool isFull();
	int id() const;
    bool joinMember(std::weak_ptr<Player> member);
    void memberExit(std::weak_ptr<Player> member);
    void relayMessagesToMembers(std::weak_ptr<Player> sender, transimissionMessage &message);
	void multicaseMessagesToMembers(transimissionMessage &message);

private:
	int m_id;
    int m_currentRoomMemberNumber;
    std::weak_ptr<Player> _roomOwner;
    std::weak_ptr<Player> _members;
};

#endif // ROOM_H
