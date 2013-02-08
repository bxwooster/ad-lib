void close_socket (
        socklib_t sock
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

