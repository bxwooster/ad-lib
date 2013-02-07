void close_socket (
        SOCKET sock
) {
    int status;
    #ifdef WINDOWS
        status = closesocket (sock);
    #else
        status = close (sock);
    #endif
    if (status != 0) log_info ("While closing a socket this happened: %s",
            socket_errstr ());
}

