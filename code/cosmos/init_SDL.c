struct SDL
init_SDL (void) {
    if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0) {
        log_info ("SDL_Init error: %s.", SDL_GetError ());
        return (struct SDL) {0};
    }

    SDL_Window * window = SDL_CreateWindow ("",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        1024, 768,
        SDL_WINDOW_OPENGL |
        //SDL_WINDOW_MINIMIZED | /* for debugging */
        //SDL_WINDOW_SHOWN);
        0);

    if (window == NULL) {
        log_info ("SDL_CreateWindow error: %s.", SDL_GetError ());
        return (struct SDL) {0};
    }

    return (struct SDL) {
        .subsystem_video = 1,
        .subsystem_timer = 1,
        .window = window,
        .ready = 1,
    };
}

