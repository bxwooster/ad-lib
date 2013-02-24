#ifndef WINDOWS
	typedef int SOCKET;
#else
	typedef int socklen_t;
#endif

void socket_init (void);
    
SOCKET socket_queriee (void);

SOCKET socket_querier (void);

void socket_close (SOCKET sock);

char const * socket_errstr (void);
