int // exitcode
main (
        int argc,
        char * argv []
)
/* Entry point. Handles the command-line arguments and proceeds. */
{
    (void) argc;
    (void) argv; /* silence the warnings */

    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;
    log_info ("Hi, I'm Roger.");

    if (socket_startup () != 0) {
        log_info ("Sockets gone wrong.");
        return 0;
    }

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) { // windows-only?
        log_info ("My socket has a problem, namely. %s!",
                socket_errstr ());
        goto end;
    }

    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);

    status = setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    if (status < 0) {
        log_info("Setsockopt has made a grave mistake. %s!",
                socket_errstr ());
        goto end;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = INADDR_ANY; // was inet_addr (ADDRESS);

    status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        log_info("Bind isn't behaving all too well. %s!",
                socket_errstr () );
        goto end;
    }

    unsigned long number;
    status = recv (sock, (void *) &number, sizeof (number), 0);
    if (status < 0) {
        log_info("Recv has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

    log_info ("Number %x!", number);

end:
    close (sock);

    return 0;
}

