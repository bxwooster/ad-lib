void
to_common_draw_GLstate (
        struct GL * gl,
        unsigned width,
        unsigned height
) {
    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, width, height);
}
