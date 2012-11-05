struct input
poll_SDLevents (struct SDL * sdl) {
    struct input currently = {0};

    (void) sdl;
    currently.mouse.buttons = SDL_GetMouseState (
            & currently.mouse.x,
            & currently.mouse.y);

    (void) sdl;
    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_KEYDOWN) {
            SDL_Keycode key = event.key.keysym.sym;
            if (key == SDLK_ESCAPE) {
                currently.halt = 1;
            }
            else if (key == SDLK_w) {
                currently.toggle_wireframe = 1;
            }
            else if (key == SDLK_n) {
                currently.toggle_normals = 1;
            }
        } else if (event.type == SDL_QUIT) {
            currently.halt = 1;
        }
    }

    return currently;
}
