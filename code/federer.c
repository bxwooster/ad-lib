int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Roger.");
    socket_init ();

    SOCKET sock = socket_queriee ();

    unsigned long number;
    struct sockaddr_in source = {0};
    int source_length = sizeof (source);

    int status = recvfrom (sock, (void *) & number, sizeof (number), 0,
            (void *) & source, & source_length);
	OK (status > 0);

    logi ("Number %x from IP %s, port %hu!", number,
            inet_ntoa (source.sin_addr),
            ntohs (source.sin_port));

    socket_close (sock);

    return 0;
}

