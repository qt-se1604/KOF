#ifndef ONLINECLIENTS_H
#define ONLINECLIENTS_H

#include "datagram.h"
#include <memory>
#include <unordered_map>
#include <list>

class Player;
class Room;

enum class PlayerRequest{
    login, createRoom, JoinRoom, relay
};

class OnlineClients {
public:
    OnlineClients();

    void playerOnlineStateUpdateMessage(DataGram &data, PlayerRequest requestType);

private:
    void handlePlayerRequest(std::weak_ptr<Player> player, transimissionMessage &message, PlayerRequest requestType);
    void createRoom(std::weak_ptr<Player> roomOwner);
    bool joinRoom(std::weak_ptr<Player> roomMember);

    void eraseThePlayer(std::shared_ptr<Player> playerToBeErase);

    std::list<std::shared_ptr<Player>> _players;
};

#endif // ONLINECLIENTS_H
