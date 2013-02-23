#ifndef WINDOWS
  #define INVALID_SOCKET -1
  #define closesocket close
#endif

static unsigned const PORT = 57294;
static char const ADDRESS [] = "224.0.0.178";

void rafael () {
    logi ("Hi, I'm Rafael.");
    SOCKET sock = socket_querier ();

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) &number, sizeof (number), 0);
	OK (status > 0);

    socket_close (sock);
}

void socket_init (void) {
#ifdef WINDOWS
	WSADATA whatever;
	int wstatus = WSAStartup (MAKEWORD (1, 1), &whatever);
	OK (wstatus == 0);
#endif
}

char const * socket_errstr (void) {
#ifndef WINDOWS
	return strerror (errno);
#else
	int status = WSAGetLastError ();
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

SOCKET socket_queriee (void) {
    int status = 0;

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        logi ("My socket has a problem, namely. %s!",
                socket_errstr ());
		OK (0);
    }

    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    status = setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    if (status < 0) {
        logi("Setsockopt has made a grave mistake. %s!",
                socket_errstr ());
		OK (0);
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = INADDR_ANY; // was inet_addr (ADDRESS);

    status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Bind isn't behaving all too well. %s!",
                socket_errstr () );
		OK (0);
    }

    return sock;
}

SOCKET socket_querier (void) {
    int status = 0;

    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        logi ("My socket has a problem, namely. %s!",
                socket_errstr ());
		OK (0);
    }

    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Connect isn't behaving all too well. %s!",
                socket_errstr ());
		OK (0);
    }

    return sock;
}

void socket_close (SOCKET sock) {
    int status = closesocket (sock);
    if (status != 0) logi ("While closing a socket this happened: %s",
            socket_errstr ());
}
