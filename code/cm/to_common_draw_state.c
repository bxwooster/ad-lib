int
to_common_draw_state (
        GLuint program,
        unsigned width,
        unsigned height,
        struct GL * gl
) {
    glUseProgram (program);
    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, width, height);

    (void) gl;
    GLuint const attribute_pos = (GLuint) glGetAttribLocation (program, "pos");
    if (attribute_pos == (GLuint) -1) {
        log_info ("GL attribute 'pos' not found");
        return 1;
    }
    glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attribute_pos);

    return 0;
}
