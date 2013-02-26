int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */
    logi ("Hi, I'm Rafael.");

    socket_init ();
    client ();

    logi ("Rafael out.");
    return 0;
}
