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

    SOCKET sock = prepare_queriee_socket (&lib);

    unsigned long number;
    int status = recv (sock, (void *) &number, sizeof (number), 0);
    if (status < 0) {
        log_info("Recv has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

    log_info ("Number %x!", number);

end:
    close_socket (sock);

    return 0;
}

