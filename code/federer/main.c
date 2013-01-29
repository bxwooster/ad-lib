int // exitcode
main (
        int argc,
        char * argv []
)
/* Entry point. Handles the command-line arguments and proceeds. */
{
    (void) argc;
    (void) argv; /* silence the warnings */

    log_info ("Hi, I'm Roger.");

    int sock = socket (PF_INET, SOCK_STREAM, 0);
    if (sock == -1) log_info ("My socket has a problem, namely: %s", strerror (errno));

    close (sock);

    return 0;
}

