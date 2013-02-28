#ifndef WINDOWS
	typedef int SOCKET;
#else
	typedef int socklen_t;
#endif

#ifndef WINDOWS
  #define INVALID_SOCKET -1
  #define closesocket close
#endif

void socket_init (void);
    
char const * socket_errstr (void);

void server (void);

void client (void);
