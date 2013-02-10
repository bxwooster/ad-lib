struct frame_DD
generate_frame_DD (
        struct SDL * sdl,
        mat4 const * proj,
        struct framestate const * state
) {
    (void) sdl;
    double time = (double) SDL_GetTicks () / 1000;

    mat4 viewi = mat4_multiply (& state->ori, & state->cam);
    mat4 view = mat4_inverted_rtonly (& viewi);
    mat4 viewproj = mat4_multiply (proj, & view);

    return (struct frame_DD) {
        time, 
        viewi,
        viewproj
    };
}

