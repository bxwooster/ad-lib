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

/******************************************************************************/

void connect_it (SOCKET sock) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (PORT_E);
    saddr.sin_addr.s_addr = inet_addr (ADDRESS);

    int status = connect (sock, (void *) &saddr, sizeof (saddr));
    OK (status == 0);
}

void multi_it (SOCKET sock) {
    struct ip_mreq imreq = {0};
    imreq.imr_multiaddr.s_addr = inet_addr (ADDRESS);
    imreq.imr_interface.s_addr = INADDR_ANY;

    int status = setsockopt (sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            (void *) &imreq, sizeof (imreq));
    OK (status == 0);
}

void bind_it (SOCKET sock, unsigned port) {
    struct sockaddr_in saddr = {0};
    saddr.sin_family = PF_INET;
    saddr.sin_port = htons (port);
    saddr.sin_addr.s_addr = INADDR_ANY;

    int status = bind (sock, (const struct sockaddr *) &saddr, sizeof (saddr));
    OK (status == 0);
}

void udp_wait (SOCKET sock) {
    char data [1];

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);
    int status = recvfrom (sock, data, sizeof (data), 0,
            (void *) & address, & addrlen);
    OK (status > 0);

    logi ("Got UDP connection from IP %s, port %hu!",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));
    sleep (1);

    status = sendto (sock, data, sizeof (data), 0,
            (void *) & address, addrlen);
    OK (status > 0);
}

void udp_go (SOCKET sock, struct sockaddr_in * remote, socklen_t * remlen) {
    char data [1];

    int status = send (sock, data, sizeof (data), 0);
	OK (status > 0);

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);
	address.sin_family = AF_UNSPEC;
    /*dis*/connect (sock, (void *) & address, addrlen);

    status = recvfrom (sock, data, sizeof (data), 0,
            (void *) & address, & addrlen);
	OK (status > 0);

    logi ("Got returning UDP conn from IP %s, port %hu!",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    *remote = address;
    *remlen = addrlen;
}

/******************************************************************************/

uint8_t const TYPE_PULL_REQUEST  = 2 | 0;
uint8_t const TYPE_PULL_RESPONSE = 2 | 1;

struct packet {
    uint8_t type;
    uint32_t id;
    uint32_t size;
    uint8_t data [0];
} __attribute__((packed)); 

void send_it (SOCKET real, struct packet * pack, size_t packlen) {
    size_t sent;
    for (size_t offset = 0; offset < packlen; offset += sent) {
        char * buffer = (char *) pack + offset;
        size_t left = packlen - offset;
        sent = send (real, (void *) buffer, left, 0);
        OK (sent > 0);
    }
}

void recv_it (SOCKET real, struct packet * pack, size_t maxlen) {
    char * buffer = (void *) pack;
    OK (maxlen > sizeof (*pack));

    int status = recv (real, (void *) buffer, sizeof (*pack), 0);
    OK (status == sizeof (*pack));
    buffer += sizeof (*pack);

    size_t size = ntohl (pack->size);
    ssize_t recd = recv (real, (void *) buffer, size, 0);
    OK ((size_t) recd == size);
}

void client (void) {
    struct sockaddr_in remote;
    socklen_t remlen;
    {
        SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
        OK (sock != INVALID_SOCKET);

        bind_it (sock, PORT_R);

        connect_it (sock);

        udp_go (sock, & remote, & remlen);

        closesocket (sock);
    }

    SOCKET real = socket (PF_INET, SOCK_STREAM, 0);
    OK (real != INVALID_SOCKET);

    bind_it (real, PORT_R);

    sleep (1);

    int status = connect (real, (void *) & remote, remlen);
    OK (status == 0);

    sleep (1);

    uint32_t last_id = 0;
    for (;;) {
        struct packet original;
        /* question */
        {
            char filename [] = "data/galaxy";
            size_t size = strlen (filename);

            size_t packlen = sizeof (struct packet) + size;
            struct packet * pack = malloc (packlen);
            OK (pack != NULL);
            pack->type = TYPE_PULL_REQUEST;
            pack->id = htonl (++last_id);
            pack->size = htonl (size);
            memcpy (pack->data, filename, size);

            send_it (real, pack, packlen);
            original = *pack;

            free (pack);
        }

        /* answer */
        {
            char rawbuf [1024];
            struct packet * pack = (void *) rawbuf; // alias

            recv_it (real, pack, 1024);

            OK (pack->id == original.id);
            OK (pack->type == (original.type | 1));

            pack->data[ntohl (pack->size)] = '\0';
            logi ("Answer (truncated to 10c) is %.10s", pack->data);
        }

        sleep (1);
    }

    closesocket (real);
}

void server (void) {
    // UDP
    {
        SOCKET sock = socket (PF_INET, SOCK_DGRAM, 0);
        OK (sock != INVALID_SOCKET);

        multi_it (sock);

        bind_it (sock, PORT_E);

        udp_wait (sock);

        closesocket (sock);
    }

    SOCKET sock = socket (PF_INET, SOCK_STREAM, 0);
    OK (sock != INVALID_SOCKET);

    bind_it (sock, PORT_E);

    int status = listen (sock, 1);
    OK (status == 0);

    struct sockaddr_in address = {0};
    socklen_t addrlen = sizeof (address);

    SOCKET real = accept (sock, (void *) & address, & addrlen);
    OK (real != INVALID_SOCKET);
    closesocket (sock);

    logi ("Got TCP connection from IP %s, port %hu",
            inet_ntoa (address.sin_addr),
            ntohs (address.sin_port));

    uint32_t last_id = 0;
    for (;;) {
        struct packet original;
        /* question */
        char * question;
        {
            char rawbuf [1024];
            struct packet * pack = (void *) rawbuf; // alias

            recv_it (real, pack, 1024);
            OK (pack->type == TYPE_PULL_REQUEST);
            uint32_t id = ntohl (pack->id);
            OK (id > last_id);
            last_id = id;
            original = *pack;

            pack->data[ntohl (pack->size)] = '\0';
            logi ("Question is %s", pack->data);
            question = (char *) pack->data;
        }

        /* answer */
        {
            char * answer = load_file (question);
            unsigned size = strlen (answer);

            size_t packlen = sizeof (struct packet) + size;
            struct packet * pack = malloc (packlen);
            OK (pack != NULL);
            pack->type = original.type | 1;
            pack->id = original.id;
            pack->size = htonl (size);
            memcpy (pack->data, answer, size);

            send_it (real, pack, packlen);

            free (pack);
        }
    }

    sleep (1);

    closesocket (real);
}

