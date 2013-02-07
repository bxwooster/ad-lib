struct socklib
init_socklib () {
    #ifdef WINDOWS
        WSADATA whatever;
        int wstatus = WSAStartup (MAKEWORD (1, 1), &whatever);
        if (wstatus != 0) {
            log_info ("Sockets gone wrong.");
            return (struct socklib) {.ready = 0};
        }
    #endif
    return (struct socklib) {.ready = 1};
}

