int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Roger.");
    socket_init ();

    SOCKET sock = socket_queriee ();

    unsigned long number;

    struct sockaddr_in source = {0};
    socklen_t source_length = sizeof (source);

	logi ("Roger listening.", socket_errstr ());
    int status = recvfrom (sock, (void *) & number, sizeof (number), 0,
            (void *) & source, & source_length);
	OK (status > 0);

    logi ("Roger: Number %x from IP %s, port %hu!", number,
            inet_ntoa (source.sin_addr),
            ntohs (source.sin_port));

	sleep (1);

    status = sendto (sock, (void *) & number, sizeof (number), 0,
            (void *) & source, source_length);
	logi ("Roger sent.", socket_errstr ());
    OK (status > 0);

    socket_close (sock);

    logi ("Roger out.");
    return 0;
}

