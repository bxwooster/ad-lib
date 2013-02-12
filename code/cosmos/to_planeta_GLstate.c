void
to_planeta_GLstate (
        struct GL * gl,
        struct GLvbo_and_size * imposter,
        struct glts_planeta const * glts
) {
    glBindBuffer (GL_ARRAY_BUFFER, imposter->vbo);
    gl->vertices = imposter->size;

    glUseProgram (glts->program);
    glVertexAttribPointer (glts->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (glts->Apos2d);
}
