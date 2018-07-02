/* This server only support two players online
 */
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/socket.h>
//#include <sys/epoll.h>
#include <signal.h>
#include <stdlib.h>

struct sockaddr_in wait_for_player();
//void disconnected(int sig);
void stop(int sig);

int socket_fd;
//int epoll_fd;
struct sockaddr_in playera;
struct sockaddr_in playerb;

int main()
{
    //signal(SIGPIPE, disconnected);
	signal(SIGINT, stop);

	struct sockaddr_in addr;
	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(10000);
	addr.sin_addr.s_addr = inet_addr("127.0.0.1");

	socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
	if(bind(socket_fd, (struct sockaddr *)&addr, sizeof(addr)) == -1)
	{
		fprintf(stderr, "bind error");
		return -1;
	}
	/*if(listen(socket_fd, 2) != 0)
	{
		fprintf(stderr, "listen error");
		return -1;
	}*/

	//epoll_fd = epoll_create(2);

	playera = wait_for_player();
    fprintf(stderr, "player a");
	playerb = wait_for_player();
    fprintf(stderr, "player b");
	fprintf(stderr, "All players online");

	struct sockaddr_in current_client;
    char buff[50];
    socklen_t client_size = sizeof(current_client);
    while(1)
    {
        memset(buff, 0, sizeof(buff));
        memset(&current_client, 0, sizeof(buff));
        recvfrom(socket_fd, buff, sizeof(buff), 0, (struct sockaddr *)&current_client, &client_size);
        if(current_client.sin_addr.s_addr == playera.sin_addr.s_addr && current_client.sin_port == playera.sin_port)
        {
            fprintf(stderr, "send to b: %s\n", buff);
            sendto(socket_fd, buff, sizeof(buff), 0, (struct sockaddr *)&playerb, sizeof(playerb));
        }
        else if(current_client.sin_addr.s_addr == playerb.sin_addr.s_addr && current_client.sin_port == playerb.sin_port)
        {
            fprintf(stderr, "send to a: %s\n", buff);
            sendto(socket_fd, buff, sizeof(buff), 0, (struct sockaddr *)&playera, sizeof(playera));
        }
    }

	/*int ready;
	struct epoll_event wait_event[2];

	while(1)
	{
		ready = epoll_wait(epoll_fd, wait_event, 2, -1);
		for(int i = 0; i <= ready; ++i)
		{
			if(wait_event[i].events & EPOLLIN)
			{
				if(playera == wait_event[i].data.fd)
				{
					memset(buff, 0, sizeof(buff));
					recv(playera, buff, sizeof(buff), 0);
					send(playerb, buff, sizeof(buff), 0);
				}
				else if(playerb == wait_event[i].data.fd)
				{
					memset(buff, 0, sizeof(buff));
					recv(playerb, buff, sizeof(buff), 0);
					send(playera, buff, sizeof(buff), 0);
				}
				fprintf(stderr, buff);
			}
		}
	}*/

	return 0;
}

struct sockaddr_in wait_for_player()
{
	//struct epoll_event event;
	/*int player = accept(socket_fd, NULL, NULL);
	if(player == -1)
		fprintf(stderr, "accept error");*/
	struct sockaddr_in player;
    socklen_t size = sizeof(player);
    char buff[50];
    recvfrom(socket_fd, buff, sizeof(buff), 0, (struct sockaddr *)&player, &size);
    while(player.sin_addr.s_addr == playera.sin_addr.s_addr && player.sin_port == playera.sin_port)
        recvfrom(socket_fd, buff, sizeof(buff), 0, (struct sockaddr *)&player, &size);
	return player;
	/*event.data.fd = player;
	event.events = EPOLLIN | EPOLLET;
	epoll_ctl(epoll_fd, EPOLL_CTL_ADD, player, &event);
	return player;*/
}

/*void disconnected(int sig)
{
	fprintf(stderr, "disconnected");

    struct epoll_event event;
	event.data.fd = playera;
	event.events = EPOLLIN | EPOLLET;
	epoll_ctl(epoll_fd, EPOLL_CTL_DEL, playera, &event);

	event.data.fd = playerb;
    epoll_ctl(epoll_fd, EPOLL_CTL_DEL, playerb, &event);

    //shutdown(playera, SHUT_RDWR);
    //shutdown(playerb, SHUT_RDWR);

	playera = wait_for_player();
	playerb = wait_for_player();
}*/

void stop(int sig)
{
	fprintf(stderr, "Stop the server");
    //shutdown(playera, SHUT_RDWR);
    //shutdown(playerb, SHUT_RDWR);
	exit(0);
}
