int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */
    logi ("Hi, I'm Roger.");
    
    socket_init ();
    SOCKET sock = socket_queriee ();
    sleep (10);
    socket_close (sock);

    logi ("Roger out.");
    return 0;
}

