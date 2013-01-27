void
to_common_draw_GLstate (
        struct GL * gl,
        unsigned width,
        unsigned height,
        struct GLvbo_and_size * imposter
) {
    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, width, height);

    (void) gl;
    glBindBuffer (GL_ARRAY_BUFFER, imposter->vbo);
    gl->vertices = imposter->size;
}
