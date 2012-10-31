void
cosmos (void) {
    log_info ("Revving up.");

    struct GL gl = {0};
    struct SDL sdl = {0};
    struct IMG img = {0};

    do {
        sdl = init_SDL ();
        if (!sdl.ready) break;

        img = init_IMG ();
        if (!img.ready) break;

        gl = init_GL (& sdl);
        if (!gl.ready) break;

        /* All systems go! */
        go (& gl, & sdl, & img);

    } while (0); /* break out */

    /* destroy GL */
    if (gl.context != NULL) SDL_GL_DeleteContext (gl.context);

    /* destroy IMG */
    if (img.ready) IMG_Quit ();

    /* destroy SDL */
    if (sdl.window != NULL) SDL_DestroyWindow (sdl.window);
    if (sdl.ready) SDL_Quit ();

    /* Commentary:
     *
     * GL, SDL, IMG are pure states, and should be handled like states.
     * This means always passing them as a pointer to (mutable!) struct.
     *
     * Destroying them should probably be in a separate function as well.
     */
}

