API struct bronze_engine * XE = NULL;

API void Pull (char const * filename, hot_callback call) {
	hot_pull (XE->H, filename, call, NULL, 0);
}

API void Require (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

API void Halt () {
    XE->halt = 1;
}

API double Time () {
    return (double) SDL_GetTicks () / 1000;
}

API int8_t Key (unsigned key) {
    if (key >= XE->key_max) return 0;
    return XE->key[key];
}

API vec2 Pointer () {
    int x, y;
    SDL_GetMouseState (& x, & y);

    float hw = XE->sdl->width / 2;
    float hh = XE->sdl->height / 2;

    float mx = (x - hw) / hw;
    float my = (y - hh) / hw;

    return (vec2) {mx, my};
}
