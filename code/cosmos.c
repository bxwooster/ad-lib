int main (int argc, char * argv []) {
    (void) argc;
    (void) argv; /* silence the warnings */

    logi ("Revving up.");

    struct SDL sdl = {0};
    struct IMG img = {0};
    struct GL  gl  = {0};

    img = init_IMG ();
    OK (img.ready);

    sdl = init_SDL ();
    OK (sdl.ready);

    gl = init_GL (& sdl);
    OK (gl.ready);

    struct stone_engine * E = stone_init (& gl, & sdl, & img);

    /* All systems go! */
    unsigned long frame = 0;

    for (;;) {
        char status = stone_do_frame (E);
        if (status) break;
        frame++;
    }

    logi ("%d frames were done. Have a nice day!", frame);

    stone_destroy (E);

    exit_GL (& gl, & sdl);
    exit_SDL (& sdl);
    exit_IMG (& img);

    return 0;
}

