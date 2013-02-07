SOCKET
prepare_querier_socket (
        struct socklib * lib
) {
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;

    (void) lib;

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) { // windows-only?
        log_info ("My socket has a problem, namely. %s!",
                strerror (socket_errno ()));
        goto error;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        log_info("Connect isn't behaving all too well. %s!",
                strerror (socket_errno ()));
        goto error;
    }

    return sock;

error:
    close_socket (sock);
    return INVALID_SOCKET;
}

