int cosmos (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Revving up.");

    init_IMG ();
    struct SDL * sdl = init_SDL ();
    struct GL * gl = init_GL (sdl);

    struct stone_engine * E = stone_init (gl, sdl);

    /* All systems go! */
    unsigned long frame = 0;

    for (;;) {
        frame++;
        char status = stone_frame (E);
        if (status != 0) break;
    }

    logi ("%d frames were done. Have a nice day!", frame);

    stone_destroy (E);

    exit_GL (gl);
    exit_SDL (sdl);
    IMG_Quit ();

    return 0;
}

