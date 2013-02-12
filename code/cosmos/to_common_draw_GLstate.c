void
to_common_draw_GLstate (
        struct stone_engine * E
) {
    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, E->width, E->height);
}
