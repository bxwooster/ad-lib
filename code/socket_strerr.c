char const *
socket_errstr () {
    int status = socket_errno ();
    #ifndef WINDOWS
        return strerror (status);
    #else
        size_t const bufsiz = 1024;
        char buffer [bufsiz];
        FormatMessage (
                FORMAT_MESSAGE_FROM_SYSTEM,
                0, // internal message table
                status,
                1033, // English
                (LPSTR) &buffer,
                bufsiz,
                NULL // no addiotional arguments
        );
        size_t len = strlen (buffer);
        buffer [len - 3] = '\0'; // no dot and CRLF
        return buffer; // note that this is not thread-safe!
    #endif
}

