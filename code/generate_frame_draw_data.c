struct frame_draw_data
generate_frame_draw_data (
        mat4 const * proj,
        struct framestate const * state
) {
    mat4 viewi = mat4_multiply (& state->ori, & state->cam);
    mat4 view = mat4_inverted_rtonly (& viewi);
    mat4 viewproj = mat4_multiply (proj, & view);

    return (struct frame_draw_data) {
        viewi,
        viewproj
    };
}

