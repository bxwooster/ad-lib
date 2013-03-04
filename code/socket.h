#ifndef WINDOWS
	typedef int SOCKET;
#else
	typedef int socklen_t;
#endif

#ifndef WINDOWS
  #define INVALID_SOCKET -1
  #define SOCKET_ERROR -1
  #define closesocket close
  #define ioctlsocket ioctl
#endif
