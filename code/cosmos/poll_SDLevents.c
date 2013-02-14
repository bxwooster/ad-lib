void
poll_SDLevents (
        struct stone_engine * E,
        struct input * currently
) {
    memset (currently, sizeof (currently), 0);

    int x, y;
    currently->mouse.buttons = SDL_GetMouseState (& x, & y);

    int hw = E->width / 2;
    int hh = E->height / 2;

    float diagonal = sqrtf (hw * hw + hh * hh);
    /* Normalize mouse coordinates by diagonal.
     * I don't feel using only width or height is proper,
     * but I have to use something, therefore - diagonal */
    currently->mouse.x = (x - hw) / diagonal;
    currently->mouse.y = (y - hh) / diagonal;
    log_debug ("%f %f", currently->mouse.y, currently->mouse.x);

    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_KEYDOWN) {
            SDL_Keycode key = event.key.keysym.sym;
            if (key == SDLK_ESCAPE) {
                currently->halt = 1;
            }
            else if (key == SDLK_w) {
                currently->toggle_wireframe = 1;
            }
            else if (key == SDLK_n) {
                currently->toggle_normals = 1;
            }
            else if (key == SDLK_SPACE) {
                currently->next_turn = 1;
            }
        } else if (event.type == SDL_QUIT) {
            currently->halt = 1;
        }
    }
}
