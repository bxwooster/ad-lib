int // exitcode
main (
        int argc,
        char * argv []
) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Roger.");

    struct socklib lib = init_socklib ();
    if (lib.ready == 0) return 0;

    socklib_t sock = prepare_queriee_socket (& lib);

    unsigned long number;
    struct sockaddr_in source = {0};
    int source_length = sizeof (source);

    int status = recvfrom (sock, (void *) & number, sizeof (number), 0,
            (void *) & source, & source_length);
    if (status <= 0) {
        logi("Recv has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

    logi ("Number %x from IP %s, port %hu!", number,
            inet_ntoa (source.sin_addr),
            ntohs (source.sin_port));

end:
    close_socket (sock);

    return 0;
}

