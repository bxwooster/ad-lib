void
cosmos (void) {
    log_info ("Revving up.");

    struct GL gl;
    struct SDL sdl;
    struct IMG img;

    do { /* structured break */

   /* Initialize SDL */
    if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0) {
        log_info ("SDL_Init error: %s.", SDL_GetError ());
        break;
    }
    sdl.ready = 1;

    int img_require = IMG_INIT_JPG;
    int img_initted = IMG_Init (img_require);

    /* Initialize IMG */
    if ((img_require & img_initted) != img_require) {
        log_info ("SDL_image error: %s.", IMG_GetError ());
        break;
    }
    img.ready = 1;
 
    Does not work at the moment: glew needs a GL context
    /* Initialize GL */
    #ifdef GLEW
        GLenum glew = glewInit();
        if (glew != GLEW_OK) {
            log_info ("GLEW error: %s.", glewGetErrorString (glew));
            break;
        }

        if (!GLEW_VERSION_2_0) {
            log_info ("GL2.0 is not supported.");
            break;
        }
    #endif
    gl.ready = 1;

    /* All systems go! */
    go (& gl, & sdl, & img);

    } while (0); /* structured break */ 

    if (img.ready) IMG_Quit ();
    if (sdl.ready) SDL_Quit ();
}

