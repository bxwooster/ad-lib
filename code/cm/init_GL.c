struct GL
init_GL (
        struct SDL const * sdl
) {
    if (SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 2) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 0) != 0)
    {
        log_info ("SDL_GL_SetAttribute error: %s.", SDL_GetError ());
        return (struct GL) {0};
    }

    SDL_GLContext context = SDL_GL_CreateContext (sdl->window);

    if (context == NULL) {
        log_info ("SDL_GL_CreateContext error: %s.", SDL_GetError ());
        return (struct GL) {0};
    }

    #ifdef GLEW
        GLenum glew = glewInit();
        if (glew != GLEW_OK) {
            log_info ("GLEW error: %s.", glewGetErrorString (glew));
            return (struct GL) {0};
        }

        if (!GLEW_VERSION_2_0) {
            log_info ("GL2.0 is not supported.");
            return (struct GL) {0};
        }
    #endif

    return (struct GL) {
        .context = context,
        .ready = 1,
    };
}

