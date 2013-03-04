uint8_t const TYPE_PULL_REQUEST  = 2 | 0;
uint8_t const TYPE_PULL_RESPONSE = 2 | 1;

size_t const SCRATCH_SIZE = 65536;

void send_it (SOCKET real, struct packet * pack, size_t packlen) {
    size_t sent;
    for (size_t offset = 0; offset < packlen; offset += sent) {
        char * buffer = (char *) pack + offset;
        size_t left = packlen - offset;
        sent = send (real, (void *) buffer, left, 0);
        OK (sent > 0);
    }
}

char recv_it (SOCKET real, struct packet * pack, size_t maxlen,
       char nonblocking) {
    char * buffer = (void *) pack;
    OK (maxlen > sizeof (*pack));

    u_long mode = nonblocking;
    int status = ioctlsocket (real, FIONBIO, & mode);
    OK (status == 0);

    status = recv (real, (void *) buffer, sizeof (*pack), 0);
    if (nonblocking && status == SOCKET_ERROR && socket_wouldblock ()) return 0;
    OK (status == sizeof (*pack));
    buffer += sizeof (*pack);

    mode = 0;
    status = ioctlsocket (real, FIONBIO, & mode);
    OK (status == 0);

    size_t size = ntohl (pack->size);
    int recd = recv (real, (void *) buffer, size, 0);
    OK ((size_t) recd == size);

    return 1;
}
