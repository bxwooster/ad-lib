struct socklib {
    char ready;
};

#ifndef WINDOWS
	#define SOCKET int
    #define INVALID_SOCKET -1
    #define closesocket close
#endif

struct socklib socket_init ();
    
SOCKET socket_queriee (struct socklib * lib);

SOCKET socket_querier (struct socklib * lib);

char const * socket_errstr ();

void socket_close (SOCKET sock);
