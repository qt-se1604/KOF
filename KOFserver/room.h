#ifndef ROOM_H
#define ROOM_H

#include "datagram.h"
#include <memory>
#include <list>

#define MAX_ROOM_MEMBER_NUMBER 2

class Player;

class Room {
public:
	Room(int id);

	//bool amITheRoomOwner(std::weak_ptr<Player> isRoomOwner);
    bool isFull();
	int id() const;
    bool joinMember(std::weak_ptr<Player> member);
    void memberExit(std::weak_ptr<Player> member);
	void setting(transimissionMessage &message);
    void relayMessagesToMembers(std::weak_ptr<Player> sender, transimissionMessage &message);
	void multicaseMessagesToMembers(transimissionMessage &message);

private:
	int m_id;
    int m_currentRoomMemberNumber;
	std::list<std::weak_ptr<Player>> _members;
	//bool m_destroyLater;

	int m_time;
	int m_music;
	int m_backgroud;
};

#endif // ROOM_H
