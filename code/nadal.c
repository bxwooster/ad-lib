int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Rafael.");
    socket_init ();

    SOCKET sock = socket_querier ();

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) & number, sizeof (number), 0);
    logi ("Rafael sent.", socket_errstr ());
	OK (status > 0);

    number = 0;

    struct sockaddr_in address = {0};
    int addrlen = sizeof (address);

	address.sin_family = AF_UNSPEC;

	connect (sock, (void *) & address, addrlen);

	logi ("Rafael listening.", socket_errstr ());
    status = recvfrom (sock, (void *) & number, sizeof (number), 0,
            (void *) & address, & addrlen);
	OK (status > 0);

    logi ("Rafael: Number %x from IP %s, port %hu!", number,
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    socket_close (sock);

    logi ("Rafael out.");
    return 0;
}
