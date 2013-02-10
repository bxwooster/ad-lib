struct cosmosA_layout const *
to_planet_GLstate (
        struct framestate const * state,
        struct GL * gl,
        struct cosmosA_glts const glts [3]
) {
    (void) gl;

    unsigned choice = 0;
    if (state->show_wireframe) {
        choice = 2;
    } else if (state->show_normals) {
        choice = 1;
    }

    GLuint attrib = glts[choice].Apos2d;
    GLuint program = glts[choice].program;
    glUseProgram (program);
    glVertexAttribPointer (attrib, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attrib);
#ifndef GLES
    GLenum poly_mode = state->show_wireframe ? GL_LINE : GL_FILL;
    glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
#endif
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    return & glts[choice].layout;
}
