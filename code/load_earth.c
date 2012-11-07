GLenum // GLformat
load_earth (
        SDL_Surface * earth [6],
        struct IMG * img,
        struct SDL * sdl
) {
    char const * const earthimg [6] = {
        "art/earth/posx.jpg",
        "art/earth/negx.jpg",
        "art/earth/posy.jpg",
        "art/earth/negy.jpg",
        "art/earth/posz.jpg",
        "art/earth/negz.jpg",
    };

    for (int i = 0; i < 6; ++i) {
        (void) img;
        earth[i] = IMG_Load (earthimg[i]);
        if (earth[i] == NULL) {
            log_info ("SDL_image error: %s", IMG_GetError ());
            return GL_FALSE;
        }
    }

    Uint32 sdlformat = earth[0]->format->format;

    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB24) return GL_RGB;
    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB888) return GL_BGRA;

    (void) sdl;
    log_info ("Unexpected texture format: %s",
        SDL_GetPixelFormatName (sdlformat)); 
    return GL_FALSE;
}

