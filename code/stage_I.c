void
stage_I (void)
/* ... where libraries are initalized and put to good use. */
{
    log_info ("Revving up.");

    struct SDL sdl = {0};
    struct IMG img = {0};
    struct GL  gl  = {0};

    /*
     * GL, SDL, IMG correspond to the state of respective external libraries.
     * Pass them as a pointer to (mutable!) struct, whenever a library is used.
     */

    do {
        img = init_IMG ();
        if (!img.ready) break;

        sdl = init_SDL ();
        if (!sdl.ready) break;

        gl = init_GL (& sdl);
        if (!gl.ready) break;

        /* All systems go! */
        stage_II (& gl, & sdl, & img);

    } while (0); /* break out */

    exit_GL (& gl, & sdl);
    exit_SDL (& sdl);
    exit_IMG (& img);
}

