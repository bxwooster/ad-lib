int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    char data [4];
    logi ("Hi, I'm Roger.");
    socket_init ();

    SOCKET sock = socket_queriee ();

    struct sockaddr_in source = {0};
    socklen_t source_length = sizeof (source);
    int status = recvfrom (sock, (void *) & data, sizeof (data), 0,
            (void *) & source, & source_length);
    OK (status > 0);

    logi ("Roger: Data %.*s from IP %s, port %hu!", sizeof (data), data,
            inet_ntoa (source.sin_addr),
            ntohs (source.sin_port));
    sleep (1);

    status = sendto (sock, (void *) & data, sizeof (data), 0,
            (void *) & source, source_length);
    OK (status > 0);

    socket_close (sock);
    logi ("Roger out.");
    return 0;
}

