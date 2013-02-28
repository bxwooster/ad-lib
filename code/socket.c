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

