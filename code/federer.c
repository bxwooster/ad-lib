int federer (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Hi, I'm Roger.");
    socket_init ();
    struct hot_server * H = hot_new_server ();

    for (;;) hot_serve (H);

    hot_del_server (H);
    logi ("Roger out.");
    return 0;
}

