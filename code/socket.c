#ifndef WINDOWS
  #define INVALID_SOCKET -1
  #define closesocket close
#endif

static unsigned const PORT_E = 57294;
static unsigned const PORT_R = 57295;
static char const ADDRESS [] = "224.0.0.178";

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
			NULL // no additional arguments
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

/******************************************************************************/

void connect_it (SOCKET sock) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT_E);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    int status = connect (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Connect isn't behaving all too well. %s!",
                socket_errstr ());
		OK (0);
    }
}

SOCKET sock_it (void) {
    SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        logi ("My socket has a problem, namely. %s!",
                socket_errstr ());
		OK (0);
    }

	return sock;
}

void multi_it (SOCKET sock) {
    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    int status = setsockopt (sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    if (status < 0) {
        logi("Setsockopt has made a grave mistake. %s!",
                socket_errstr ());
		OK (0);
    }
}

void bind_it (SOCKET sock, unsigned port) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (port);
    saddr.sin_addr.s_addr = INADDR_ANY;

    int status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    if (status < 0) {
        logi("Bind isn't behaving all too well. %s!",
                socket_errstr () );
		OK (0);
    }
}

SOCKET socket_queriee (void) {
	SOCKET sock = sock_it ();

	multi_it (sock);
	bind_it (sock, PORT_E);

    return sock;
}

SOCKET socket_querier (void) {
	SOCKET sock = sock_it ();

	multi_it (sock);
	bind_it (sock, PORT_R);
	connect_it (sock);

    return sock;
}
