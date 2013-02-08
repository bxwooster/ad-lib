int // exitcode
main (
        int argc,
        char * argv []
) {
    (void) argc;
    (void) argv; /* silence the warnings */

    log_info ("Hi, I'm Roger.");

    struct socklib lib = init_socklib ();
    if (lib.ready == 0) return 0;

    socklib_t sock = prepare_queriee_socket (&lib);

    unsigned long number;
    struct sockaddr_in source = {0};
    unsigned source_length = sizeof (source);

    int status = recvfrom (sock, (void *) &number, sizeof (number), 0,
            (void *) &source, &source_length);
    if (status < 0) {
        log_info("Recv has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

    log_info ("Number %x from IP %s!", number, inet_ntoa (source.sin_addr));

end:
    close_socket (sock);

    return 0;
}

