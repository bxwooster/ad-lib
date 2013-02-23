int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Rafael.");
    socket_init ();

    SOCKET sock = socket_querier ();

    unsigned long number = 0xF00DCAFE;
    int status = send (sock, (void *) &number, sizeof (number), 0);
	OK (status > 0);

    socket_close (sock);
}
