int
socket_errno () {
    #ifdef WINDOWS
        return WSAGetLastError();
    #else
        return errno;
    #endif
}

