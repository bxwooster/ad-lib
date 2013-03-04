unsigned const PORT_E = 57294;
unsigned const PORT_R = 57295;
char const ADDRESS [] = "224.0.0.178";

void connect_it (SOCKET sock) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT_E);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    int status = connect (sock, (void *) &saddr, sizeof (saddr));
    OK (status == 0);
}

void multi_it (SOCKET sock) {
    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    int status = setsockopt (sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    OK (status == 0);
}

void bind_it (SOCKET sock, unsigned port) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (port);
    saddr.sin_addr.s_addr = INADDR_ANY;

    int status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    OK (status == 0);
}

void udp_wait (SOCKET sock) {
    char data [1];

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);
    int status = recvfrom (sock, data, sizeof (data), 0,
            (void *) & address, & addrlen);
    OK (status > 0);

    logi ("Got UDP connection from IP %s, port %hu!",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));
    sleep (1);

    status = sendto (sock, data, sizeof (data), 0,
            (void *) & address, addrlen);
    OK (status > 0);
}

void udp_go (SOCKET sock, struct sockaddr_in * remote, socklen_t * remlen) {
    char data [1];

    int status = send (sock, data, sizeof (data), 0);
	OK (status > 0);

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);
	address.sin_family = AF_UNSPEC;
    /*dis*/connect (sock, (void *) & address, addrlen);

    status = recvfrom (sock, data, sizeof (data), 0,
            (void *) & address, & addrlen);
	OK (status > 0);

    logi ("Got returning UDP conn from IP %s, port %hu!",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    *remote = address;
    *remlen = addrlen;
}

SOCKET hot_player_socket (void) {
    struct sockaddr_in remote;
    socklen_t remlen;
    {
        SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
        OK (sock != INVALID_SOCKET);

        bind_it (sock, PORT_R);

        connect_it (sock);

        udp_go (sock, & remote, & remlen);

        closesocket (sock);
    }

    SOCKET real = socket (PF_INET, SOCK_STREAM, 0);
    OK (real != INVALID_SOCKET);

    bind_it (real, PORT_R);

    sleep (1);

    int status = connect (real, (void *) & remote, remlen);
    OK (status == 0);
    
    return real;
}

SOCKET hot_server_socket (void) {
    // UDP
    {
        SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
        OK (sock != INVALID_SOCKET);

        multi_it (sock);

        bind_it (sock, PORT_E);

        udp_wait (sock);

        closesocket (sock);
    }

    // TCP
    SOCKET sock = socket (PF_INET, SOCK_STREAM, 0);
    OK (sock != INVALID_SOCKET);

    bind_it (sock, PORT_E);

    int status = listen (sock, 1);
    OK (status == 0);

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);

    SOCKET real = accept (sock, (void *) & address, & addrlen);
    OK (real != INVALID_SOCKET);
    closesocket (sock);

    logi ("Got TCP connection from IP %s, port %hu",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    return real;
}
