int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */
    logi ("Hi, I'm Rafael.");

    socket_init ();
    SOCKET sock = socket_querier ();
    sleep (5);
    socket_close (sock);

    logi ("Rafael out.");
    return 0;
}
