int cosmos (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Revving up.");

#ifdef HOTREMOTE
    socket_init ();
#endif

    struct SDL * sdl = init_SDL ();
    struct bronze_engine * E = bronze_init (sdl);

    /* All systems go! */
    unsigned long frame = 0;

    for (;;) {
        frame++;
        char status = bronze_frame (E);
        if (status != 0) break;
    }

    logi ("%d frames were done. Have a nice day!", frame);

    bronze_destroy (E);
    exit_SDL (sdl);

    return 0;
}

