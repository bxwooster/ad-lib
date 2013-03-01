int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Rafael.");
    socket_init ();
    SOCKET real = hot_player_socket ();

    for (;;) {
        hot_play (real, "data/galaxy");
        sleep (1);
    }

    closesocket (real);
    logi ("Rafael out.");
    return 0;
}
