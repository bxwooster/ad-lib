int
bad_socket () {
    #ifdef WINDOWS
        return INVALID_SOCKET;
    #else
        return -1;
    #endif
}
