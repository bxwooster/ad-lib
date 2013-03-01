struct GL
init_GL (
        struct SDL const * sdl
) {
    if (SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 2) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 0) != 0)
    {
        logi ("SDL_GL_SetAttribute error: %s.", SDL_GetError ());
        return (struct GL) {0};
    }

    SDL_GLContext context = SDL_GL_CreateContext (sdl->window);

    if (context == NULL) {
        logi ("SDL_GL_CreateContext error: %s.", SDL_GetError ());
        return (struct GL) {0};
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

    return (struct GL) {
        .context = context,
        .ready = 1,
    };
}

struct IMG
init_IMG (void) {
    int require = IMG_INIT_JPG;
    int initted = IMG_Init (require);

    if ((require & initted) != require) {
        logi ("SDL_image error: %s.", IMG_GetError ());
        return (struct IMG) {0};
    }

    return (struct IMG) {
        .type_jpg = 1,
        .ready = 1,
    };
}

struct SDL
init_SDL (void) {
    if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0) {
        logi ("SDL_Init error: %s.", SDL_GetError ());
        return (struct SDL) {0};
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

    if (window == NULL) {
        logi ("SDL_CreateWindow error: %s.", SDL_GetError ());
        return (struct SDL) {0};
    }

    return (struct SDL) {
        .subsystem_video = 1,
        .subsystem_timer = 1,
        .window = window,
        .width = width,
        .height = height,
        .ready = 1,
    };
}

void
exit_GL (
        struct GL * gl,
        struct SDL * sdl
) {
    (void) sdl;
    if (gl->context != NULL) {
        SDL_GL_DeleteContext (gl->context);
    }
    gl->ready = 0;
}

void
exit_IMG (
        struct IMG * img
) {
    if (img->ready) {
        IMG_Quit ();
        img->ready = 0;
    }
}

void
exit_SDL (
        struct SDL * sdl
) {
    if (sdl->window != NULL) {
        SDL_DestroyWindow (sdl->window);
    }
    if (sdl->ready) {
        SDL_Quit ();
        sdl->ready = 0;
    }
}
