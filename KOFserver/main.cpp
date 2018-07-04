#include <iostream>
#include "udpserver.h"
#include "datagram.h"
#include "onlineclients.h"
#include <string>
#include <json/json.h>
#include <json/reader.h>
#include <json/value.h>

using std::string;

int main()
{
    DataGram data;
	OnlineClients manage;

    Json::Value root;
    Json::Reader jsReader;

    while(true)
    {
        UdpServer::getServer() >> data;
		string jsonString(data.message.begin(), data.message.end());

		jsReader.parse(jsonString, root);
		if(root.isMember("x") || root.isMember("y") ||
				root.isMember("fire") || root.isMember("jump"))
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::relay);
		if(root.isMember("createRoom") && root["createRoom"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::createRoom);
		if(root.isMember("joinRoom") && root["joinRoom"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::JoinRoom);
		if(root.isMember("login") && root["login"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::login);
    }

	return 0;
}
