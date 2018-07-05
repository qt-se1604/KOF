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
		//relay message
		if(root.isMember("x") || root.isMember("y")
				|| root.isMember("fire") || root.isMember("jump"))
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::relay);

		//command to server
		if(root.isMember("createRoom") && root["createRoom"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::createRoom);
		if(root.isMember("joinRoom") && root["joinRoom"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::JoinRoom);
		if(root.isMember("login") && root["login"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::login);
		if(root.isMember("quitRoom") && root["quitRoom"].asBool())
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::quitRoom);

		//set room
		if(root.isMember("time") || root.isMember("music")
				|| root.isMember("background"))
			manage.playerOnlineStateUpdateMessage(data, PlayerRequest::setRoom);
    }

	return 0;
}
