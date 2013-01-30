int
socket_startup () {
    #ifdef WINDOWS
        WSADATA whatever;
        return WSAStartup (MAKEWORD (1, 1), &whatever);
    #else
        return 0;
    #endif
}

