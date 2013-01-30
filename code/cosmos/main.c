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
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;
    log_info ("Hi, I'm Dodger.");

    if (socket_startup () != 0) {
        log_info ("Sockets gone wrong.");
        return 0;
    }

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) { // windows-only?
        log_info ("My socket has a problem, namely. %s!",
                strerror (socket_errno ()));
        goto end;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        log_info("Connect isn't behaving all too well. %s!",
                strerror (socket_errno ()));
        goto end;
    }

    unsigned long number = 0xF00DCAFE;
    status = send (sock, (void *) &number, sizeof (number), 0);
    if (status < 0) {
        log_info("Send has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

end:
    close (sock);
    return 0;

/* sandbox area no more */

    stage_I ();

    return 0;
}

