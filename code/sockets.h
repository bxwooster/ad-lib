// these #includes need to be reviewed,
// they are copy-pasted
#include <stdio.h>
#include <stdarg.h>
// needed for log_info, nasty to include here
#include <string.h>
// strerror
#include <unistd.h>
// close

#ifdef WINDOWS
	#include <winsock.h>
#else
	#include <sys/socket.h>
	// socket
	#include <netinet/in.h>
	// ip_mreq, sockaddr_in
	#include <arpa/inet.h>
	// inet_addr
#endif

#include <errno.h>
// err.. no?

struct socklib {
    char ready;
};

#ifdef WINDOWS
    typedef SOCKET socklib_t;
#else
    typedef int socklib_t;
#endif

void
dodger ();

struct socklib
init_socklib ();
    
socklib_t
prepare_queriee_socket (
        struct socklib * lib
);

socklib_t
prepare_querier_socket (
        struct socklib * lib
);

int
socket_errno ();

char const *
socket_errstr ();

void close_socket (
    socklib_t sock
);
