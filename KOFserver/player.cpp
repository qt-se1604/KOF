#include "player.h"
#include "room.h"
#include "udpserver.h"

using std::weak_ptr;			using std::make_shared;

Player::Player(int id, socketaddr addr)
	: m_id{id}, _belongToRoom{nullptr}, m_addr{addr}, m_timeToLive{REST_TIME_TO_LIVE}
{}

bool Player::isRoomOwner()
{
	if(_belongToRoom.use_count() == 0)
		return false;
    return _belongToRoom->amITheRoomOwner(weak_from_this());
}

bool Player::myRoomIsNotFull()
{
	if(_belongToRoom.use_count() == 0)
		return false;
	return !_belongToRoom->isFull();
}

void Player::createRoom(int roomId)
{
	_belongToRoom = make_shared<Room>(roomId, weak_from_this());
}

bool Player::joinInRoom(std::weak_ptr<Room> stay)
{
    if(stay.lock()->joinMember(weak_from_this()))
    {
        _belongToRoom = stay.lock();
        return true;
    }
    return false;
}

weak_ptr<Room> Player::myRoom()
{
    return _belongToRoom;
}

int Player::id() const
{
	return m_id;
}

int Player::updateTimeToLive(bool isRecivedDataFromThis)
{
    if(isRecivedDataFromThis)
        return (m_timeToLive = REST_TIME_TO_LIVE);
    return --m_timeToLive;
}

bool Player::matchesMyAddr(socketaddr addr)
{
    return addr == m_addr;
}

void Player::exitTheGame()
{
	if(_belongToRoom.use_count() == 0)
		return;
    _belongToRoom->memberExit(weak_from_this());
    _belongToRoom = nullptr;
}

void Player::sendToMe(transimissionMessage message)
{
    DataGram data;
    data.addr = m_addr;
    data.message = std::move(message);
    UdpServer::getServer() << data;
}

void Player::messageToMyRoom(transimissionMessage &message)
{
	if(_belongToRoom.use_count() == 0)
		return;
    _belongToRoom->relayMessagesToMembers(weak_from_this(), message);
}
