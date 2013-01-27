struct IMG
init_IMG (void) {
    int require = IMG_INIT_JPG;
    int initted = IMG_Init (require);

    if ((require & initted) != require) {
        log_info ("SDL_image error: %s.", IMG_GetError ());
        return (struct IMG) {0};
    }

    return (struct IMG) {
        .type_jpg = 1,
        .ready = 1,
    };
}

