int /* quit */
poll_SDLevents (struct SDL * sdl) {
    int quit = 0;

    (void) sdl;
    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_KEYDOWN) {
            SDL_Keycode key = event.key.keysym.sym;
            if (key == SDLK_ESCAPE) {
                quit = 1;
            }
        } else if (event.type == SDL_QUIT) {
            quit = 1;
        }
    }

    return quit;
}
