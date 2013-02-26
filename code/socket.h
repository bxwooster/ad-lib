#ifndef WINDOWS
	typedef int SOCKET;
#else
	typedef int socklen_t;
#endif

void socket_init (void);
    
char const * socket_errstr (void);

void server (void);

void client (void);
