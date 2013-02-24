int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    char data [4] = "yes.";
    logi ("Hi, I'm Rafael.");
    socket_init ();

    SOCKET sock = socket_querier ();

    int status = send (sock, (void *) & data, sizeof (data), 0);
	OK (status > 0);

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);
	address.sin_family = AF_UNSPEC;
    /*dis*/connect (sock, (void *) & address, addrlen);

    status = recvfrom (sock, (void *) & data, sizeof (data), 0,
            (void *) & address, & addrlen);
	OK (status > 0);

    logi ("Rafael: Data %.*s from IP %s, port %hu!", sizeof (data), data,
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    socket_close (sock);
    logi ("Rafael out.");
    return 0;
}
