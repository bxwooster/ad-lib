void
cosmos (void) {
    log_info ("Revving up.");

    struct SDL sdl = {0};
    struct IMG img = {0};
    struct GL  gl  = {0};

    do {
        img = init_IMG ();
        if (!img.ready) break;

        sdl = init_SDL ();
        if (!sdl.ready) break;

        gl = init_GL (& sdl);
        if (!gl.ready) break;

        /* All systems go! */
        go (& gl, & sdl, & img);

    } while (0); /* break out */

    exit_GL (& gl, & sdl);
    exit_SDL (& sdl);
    exit_IMG (& img);

    /* Commentary:
     *
     * GL, SDL, IMG are pure states, and should be handled like states.
     * This means always passing them as a pointer to (mutable!) struct.
     *
     */
}

