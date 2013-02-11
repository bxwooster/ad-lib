void
to_planet_GLstate (
        struct framestate const * state,
        struct planeta_glts const * glts
) {
    GLuint attrib = glts->Apos2d;
    GLuint program = glts->program;
    glUseProgram (program);
    glVertexAttribPointer (attrib, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attrib);
#ifndef GLES
    GLenum poly_mode = state->show_wireframe ? GL_LINE : GL_FILL;
    glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
#endif
}
