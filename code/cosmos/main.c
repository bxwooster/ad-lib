int // exitcode
main (
        int argc,
        char * argv []
)
/* Entry point. Handles the command-line arguments and proceeds. */
{
    (void) argc;
    (void) argv; /* silence the warnings */

    /* sandbox area */
    log_info ("Hi, I'm Dodger.");

    struct socklib lib = init_socklib ();
    if (lib.ready == 0) return 0;

    socklib_t sock = prepare_querier_socket (&lib);

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) &number, sizeof (number), 0);
    if (status <= 0) {
        log_info("Send has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

end:
    close_socket (sock);
    return 0;

    /* sandbox area no more */

    stage_I ();

    return 0;
}

