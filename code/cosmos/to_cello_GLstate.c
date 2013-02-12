void
to_cello_GLstate (
        struct framestate const * state,
        struct glts_cello const * glts
) {
    glUseProgram (glts->program);
    glVertexAttribPointer (glts->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (glts->Apos2d);
#ifndef GLES
    GLenum poly_mode = state->show_wireframe ? GL_LINE : GL_FILL;
    glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
#endif
}
