struct input
determine_input (
        struct SDL * sdl
) {
    struct input currently;

    (void) sdl;
    currently.mouse.buttons = SDL_GetMouseState (
            & currently.mouse.x,
            & currently.mouse.y);

    return currently;
}
