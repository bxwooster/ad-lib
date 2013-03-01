#ifndef WINDOWS
	typedef int SOCKET;
#else
	typedef int socklen_t;
#endif

#ifndef WINDOWS
  #define INVALID_SOCKET -1
  #define closesocket close
#endif
