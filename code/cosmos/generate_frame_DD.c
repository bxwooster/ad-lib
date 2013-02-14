struct frame_DD
generate_frame_DD (
        mat4 const * proj,
        struct framestate const * state
) {
    mat4 viewi = state->cam;
    mat4 view = mat4_inverted_rtonly (& viewi);
    mat4 viewproj = mat4_multiply (proj, & view);

    return (struct frame_DD) {
        viewi,
        viewproj
    };
}

