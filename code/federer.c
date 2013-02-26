int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */
    logi ("Hi, I'm Roger.");

    socket_init ();
    server ();

    logi ("Roger out.");
    return 0;
}

