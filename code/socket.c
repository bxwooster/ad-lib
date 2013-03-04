static char socket_scratch [256];

void socket_init (void) {
#ifdef WINDOWS
	WSADATA whatever;
	int wstatus = WSAStartup (MAKEWORD (1, 1), &whatever);
	OK (wstatus == 0);
#endif
}

char socket_wouldblock () {
    int err = socket_errno ();
#ifndef WINDOWS
    return err == EAGAIN || err == EWOULDBLOCK;
#else
    return err == WSAEWOULDBLOCK;
#endif
}

int socket_errno (void) {
#ifndef WINDOWS
	return errno;
#else
	return WSAGetLastError ();
#endif
}

char const * socket_errstr (void) {
#ifndef WINDOWS
	return strerror (errno);
#else
	int status = WSAGetLastError ();
	FormatMessage (
			FORMAT_MESSAGE_FROM_SYSTEM,
			0, // internal message table
			status,
			1033, // English
			(LPSTR) &socket_scratch,
			256,
			NULL // no additional arguments
	);
	size_t len = strlen (socket_scratch);
	socket_scratch [len - 3] = '\0'; // no dot and CRLF
	return socket_scratch; // note that this is not thread-safe!
#endif
}

