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

