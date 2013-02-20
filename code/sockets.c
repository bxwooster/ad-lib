void
dodger () {
    log_info ("Hi, I'm Dodger.");

    struct socklib lib = init_socklib ();
    if (lib.ready == 0) return;

    socklib_t sock = prepare_querier_socket (&lib);

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) &number, sizeof (number), 0);
    if (status <= 0) {
        log_info("Send has it a bit wrong. %s!", strerror (socket_errno ()));
        goto end;
    }

end:
    close_socket (sock);
}

struct socklib
init_socklib () {
    #ifdef WINDOWS
        WSADATA whatever;
        int wstatus = WSAStartup (MAKEWORD (1, 1), &whatever);
        if (wstatus != 0) {
            log_info ("Sockets gone wrong.");
            return (struct socklib) {.ready = 0};
        }
    #endif
    return (struct socklib) {.ready = 1};
}

socklib_t
prepare_queriee_socket (
        struct socklib * lib
) {
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;

    (void) lib;

    socklib_t sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == bad_socket ()) {
        log_info ("My socket has a problem, namely. %s!",
                socket_errstr ());
        goto error;
    }

    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    status = setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    if (status < 0) {
        log_info("Setsockopt has made a grave mistake. %s!",
                socket_errstr ());
        goto error;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = INADDR_ANY; // was inet_addr (ADDRESS);

    status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        log_info("Bind isn't behaving all too well. %s!",
                socket_errstr () );
        goto error;
    }

    return sock;

error:
    close_socket (sock);
    return bad_socket ();
}

socklib_t
prepare_querier_socket (
        struct socklib * lib
) {
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;

    (void) lib;

    socklib_t sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == bad_socket ()) {
        log_info ("My socket has a problem, namely. %s!",
                socket_errstr ());
        goto error;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        log_info("Connect isn't behaving all too well. %s!",
                strerror (socket_errno ()));
        goto error;
    }

    return sock;

error:
    close_socket (sock);
    return bad_socket ();
}

int
socket_errno () {
    #ifdef WINDOWS
        return WSAGetLastError();
    #else
        return errno;
    #endif
}

char const *
socket_errstr () {
    int status = socket_errno ();
    #ifndef WINDOWS
        return strerror (status);
    #else
        size_t const bufsiz = 1024;
        char buffer [bufsiz];
        FormatMessage (
                FORMAT_MESSAGE_FROM_SYSTEM,
                0, // internal message table
                status,
                1033, // English
                (LPSTR) &buffer,
                bufsiz,
                NULL // no addiotional arguments
        );
        size_t len = strlen (buffer);
        buffer [len - 3] = '\0'; // no dot and CRLF
        char const * warning_disabler = buffer;
        return warning_disabler; // note that this is not thread-safe!
    #endif
}

int
bad_socket () {
    #ifdef WINDOWS
        return INVALID_SOCKET;
    #else
        return -1;
    #endif
}

void close_socket (
        socklib_t sock
) {
    int status;
    #ifdef WINDOWS
        status = closesocket (sock);
    #else
        status = close (sock);
    #endif
    if (status != 0) log_info ("While closing a socket this happened: %s",
            socket_errstr ());
}

