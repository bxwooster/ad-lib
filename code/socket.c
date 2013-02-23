void dodger () {
    logi ("Hi, I'm Dodger.");

    struct socklib lib = socket_init ();
    if (lib.ready == 0) return;

    SOCKET sock = socket_querier (&lib);

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) &number, sizeof (number), 0);
    if (status <= 0) {
        logi("Recv has it a bit wrong. %s!", socket_errstr ());
        goto end;
    }

end:
    socket_close (sock);
}

struct socklib socket_init () {
    #ifdef WINDOWS
        WSADATA whatever;
        int wstatus = WSAStartup (MAKEWORD (1, 1), &whatever);
        if (wstatus != 0) {
            logi ("Sockets gone wrong.");
            return (struct socklib) {.ready = 0};
        }
    #endif
    return (struct socklib) {.ready = 1};
}

SOCKET socket_queriee (struct socklib * lib) {
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;

    (void) lib;

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        logi ("My socket has a problem, namely. %s!",
                socket_errstr ());
        goto error;
    }

    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    status = setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    if (status < 0) {
        logi("Setsockopt has made a grave mistake. %s!",
                socket_errstr ());
        goto error;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = INADDR_ANY; // was inet_addr (ADDRESS);

    status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Bind isn't behaving all too well. %s!",
                socket_errstr () );
        goto error;
    }

    return sock;

error:
    socket_close (sock);
    return INVALID_SOCKET;
}

SOCKET socket_querier (struct socklib * lib) {
    unsigned const PORT = 57294;
    char const ADDRESS [] = "224.0.0.178";
    int status = 0;

    (void) lib;

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        logi ("My socket has a problem, namely. %s!",
                socket_errstr ());
        goto error;
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Connect isn't behaving all too well. %s!",
                socket_errstr ());
        goto error;
    }

    return sock;

error:
    socket_close (sock);
    return INVALID_SOCKET;
}

int socket_errno () {
    #ifdef WINDOWS
        return WSAGetLastError();
    #else
        return errno;
    #endif
}

char const * socket_errstr () {
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

void socket_close (SOCKET sock) {
    int status = closesocket (sock);
    if (status != 0) logi ("While closing a socket this happened: %s",
            socket_errstr ());
}
