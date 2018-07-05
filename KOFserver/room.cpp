#include "room.h"
#include "udpserver.h"
#include "player.h"
#include <iostream>
#include <json/json.h>
#include <string>
#include <algorithm>

using std::cout;			using std::endl;
using std::string;			using std::copy;
using std::back_inserter;	using std::weak_ptr;
using std::find;

Room::Room(int id)
	: m_id{id}, m_currentRoomMemberNumber{0}
{}

/*bool Room::amITheRoomOwner(std::weak_ptr<Player> isRoomOwner)
{
    return isRoomOwner.lock() == _roomOwner.lock();
}*/

bool Room::isFull()
{
	return m_currentRoomMemberNumber == MAX_ROOM_MEMBER_NUMBER;
}

int Room::id() const
{
	return m_id;
}

bool Room::joinMember(std::weak_ptr<Player> member)
{
    if(!isFull())
    {
		_members.push_back(member);
		++m_currentRoomMemberNumber;
		if(isFull())
		{
			transimissionMessage message;

			//write settings
			Json::Value roomSetting;
			roomSetting["time"] = m_time;
			roomSetting["music"] = m_music;
			roomSetting["background"] = m_backgroud;
			Json::FastWriter writer;
			string jsonSetting = writer.write(roomSetting);
			message.fill(0);
			copy(jsonSetting.begin(), jsonSetting.end(), message.begin());
			multicaseMessagesToMembers(message);

			//send find game
			Json::Value findGame;
			findGame["findgame"] = true;
			Json::FastWriter findWriter;
			string jsonFind = findWriter.write(findGame);
			message.fill(0);
			copy(jsonFind.begin(), jsonFind.end(), message.begin());
			multicaseMessagesToMembers(message);
		}

        return true;
    }
	cout << "Room " << m_id << " is full, can not join" << endl;
    return false;
}

void Room::memberExit(std::weak_ptr<Player> member)
{
	Json::Value quit;
	quit["quitRoom"] = true;
	Json::FastWriter writer;
	string jsonSetting = writer.write(quit);
	transimissionMessage message;
	message.fill(0);
	copy(jsonSetting.begin(), jsonSetting.end(), message.begin());
	relayMessagesToMembers(member, message);

	--m_currentRoomMemberNumber;
	member.lock()->destroyMyRoom();
}

void Room::setting(transimissionMessage &message)
{
	Json::Value root;
	Json::Reader jsReader;
	string jsonString(message.begin(), message.end());
	jsReader.parse(jsonString, root);

	if(root.isMember("time"))
	{
		m_time = root["time"].asInt();
		cout << "Set room " << m_id << " : time to " << m_time << endl;
	}
	if(root.isMember("music"))
	{
		m_music = root["music"].asInt();
		cout << "Set room " << m_id << " : music to " << m_music << endl;
	}
	if(root.isMember("background"))
	{
		m_backgroud = root["background"].asInt();
		cout << "Set room " << m_id << " : background to " << m_backgroud << endl;
	}
}

void Room::relayMessagesToMembers(std::weak_ptr<Player> sender, transimissionMessage &message)
{
	for(auto tmp : _members)
		if(sender.lock() != tmp.lock() && !tmp.expired())
			tmp.lock()->sendToMe(message);
}

void Room::multicaseMessagesToMembers(transimissionMessage &message)
{
	for(auto tmp : _members)
		if(!tmp.expired())
			tmp.lock()->sendToMe(message);
}
