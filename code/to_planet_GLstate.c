struct cosmosA_layout const *
to_planet_GLstate (
        struct framestate const * state,
        struct GL * gl,
        struct cosmosA_glts const glts [3]
) {
    (void) gl;

    GLuint program = GL_FALSE;
    unsigned choice = 0;

    if (state->show_wireframe) {
        choice = 2;
    } else if (state->show_normals) {
        choice = 1;
    }

    program = glts[choice].program;
    glUseProgram (program);
    GLuint attribute_pos = (GLuint) glGetAttribLocation (program, "Apos2d");
    if (attribute_pos == (GLuint) -1) {
        log_info ("GL attribute 'pos' not found");
    }
    glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attribute_pos);
#ifndef GLES
    GLenum poly_mode = state->show_wireframe ? GL_LINE : GL_FILL;
    glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
#endif
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    return & glts[choice].layout;
}
