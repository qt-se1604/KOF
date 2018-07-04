#include "onlineclients.h"
#include "player.h"
#include "room.h"
#include "udpserver.h"
#include <algorithm>
#include <iostream>

using std::shared_ptr;      using std::make_shared;
using std::list;            using std::find;
using std::cout;            using std::endl;

OnlineClients::OnlineClients()
{}

void OnlineClients::playerOnlineStateUpdateMessage(DataGram &data, PlayerRequest requestType)
{
    bool thePlayerIsOnline{false};
	list<shared_ptr<Player>> playerListToBeErase;

    for(shared_ptr<Player> player : _players)
    {
        if(player->matchesMyAddr(data.addr))
        {
            player->updateTimeToLive(true);
            thePlayerIsOnline = true;
            handlePlayerRequest(player, data.message, requestType);
        }
        else if(player->updateTimeToLive(false) <= 0)
        {
			cout << "Player out of time, add to erase list" << endl;
			playerListToBeErase.push_back(player);
        }
    }

	//if the player first send message, add it to player list
    if(!thePlayerIsOnline && requestType == PlayerRequest::login)
    {
		static int currentMaxPlayerNumber = 0;
		cout << "New player online, id on server: " << currentMaxPlayerNumber << endl;
		_players.push_back(make_shared<Player>(currentMaxPlayerNumber++, data.addr));
    }

	//erase out of time players
	for(shared_ptr<Player> erasePlayer : playerListToBeErase)
	{
		cout << "Try to erase player " << erasePlayer->id() << endl;
		eraseThePlayer(erasePlayer);
	}
}

void OnlineClients::handlePlayerRequest(std::weak_ptr<Player> player, transimissionMessage &message, PlayerRequest requestType)
{
    //creat room or join room
    switch(requestType)
    {
        case PlayerRequest::createRoom:
            createRoom(player);
            break;
        case PlayerRequest::JoinRoom:
            joinRoom(player);
            break;
        case PlayerRequest::relay:
			player.lock()->messageToMyRoom(message);
            break;
        default:
            ;//others
    }
}

void OnlineClients::createRoom(std::weak_ptr<Player> roomOwner)
{
	static int currentMaxRoomId = 0;
	cout << "Player " << roomOwner.lock()->id() << " create room " << currentMaxRoomId << endl;
	roomOwner.lock()->createRoom(currentMaxRoomId++);
}

bool OnlineClients::joinRoom(std::weak_ptr<Player> roomMember)
{
	cout << "Player " << roomMember.lock()->id() << " try to find room" << endl;
    for(shared_ptr<Player> player : _players)
		if(player->isRoomOwner() && player->myRoomIsNotFull())
        {
			roomMember.lock()->joinInRoom(player->myRoom());
			cout << "Player " << roomMember.lock()->id() << " joined room " << player->myRoom().lock()->id() << endl;
            return true;
        }
	cout << "No room find" << endl;
    return false;
}

void OnlineClients::eraseThePlayer(std::shared_ptr<Player> playerToBeErase)
{
	playerToBeErase->exitTheGame();
	auto offlinePlayer = find(_players.begin(), _players.end(), playerToBeErase);
	if(offlinePlayer == _players.end())
		cout << "Not find the player" << endl;
	else
		_players.erase(offlinePlayer);
}
