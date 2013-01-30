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
