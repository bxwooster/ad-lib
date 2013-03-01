struct GL * init_GL (struct SDL const * sdl) {
    char attr =
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 2) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 0) != 0;

    OK_ELSE (attr == 0) {
        logi ("SDL_GL_SetAttribute error: %s.", SDL_GetError ());
    }

    SDL_GLContext context = SDL_GL_CreateContext (sdl->window);

    OK_ELSE (context != NULL) {
        logi ("SDL_GL_CreateContext error: %s.", SDL_GetError ());
    }

#ifdef GLEW
    GLenum glew = glewInit();

    OK_ELSE (glew == GLEW_OK) {
        logi ("GLEW error: %s.", glewGetErrorString (glew));
    }

    OK_ELSE (GLEW_VERSION_2_0) {
        logi ("GL2.0 is not supported.");
    }
#endif

    struct GL * gl = malloc (sizeof (*gl));
    gl->context = context;

    return gl;
}

void init_IMG (void) {
    int require = IMG_INIT_JPG;
    int initted = IMG_Init (require);

    OK_ELSE ((require & initted) == require) {
        logi ("SDL_image error: %s.", IMG_GetError ());
    }
}

struct SDL * init_SDL (void) {
    OK_ELSE (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) >= 0) {
        logi ("SDL_Init error: %s.", SDL_GetError ());
    }

    unsigned width = 1024;
    unsigned height = 768;
    /* bug: this is the size of the window, not of framebuffer as wanted */

    SDL_Window * window = SDL_CreateWindow ("",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        width, height,
        SDL_WINDOW_OPENGL |
        //SDL_WINDOW_SHOWN);
        0);

    OK_ELSE (window != NULL) {
        logi ("SDL_CreateWindow error: %s.", SDL_GetError ());
    }

    struct SDL * sdl = malloc (sizeof (*sdl));
    OK (sdl != NULL);

    sdl->window = window;
    sdl->width = width;
    sdl->height = height;

    return sdl;
}

void exit_GL (struct GL * gl) {
    SDL_GL_DeleteContext (gl->context);
    free (gl);
}

void exit_SDL (struct SDL * sdl) {
    if (sdl->window != NULL) {
        SDL_DestroyWindow (sdl->window);
    }

    SDL_Quit ();
    free (sdl);
}
