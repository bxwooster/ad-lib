void moduleC (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    struct glts_cello const * shader = E->sh_ce;

    glBindBuffer (GL_ARRAY_BUFFER, E->imposter->vbo);
    E->gl->vertices = E->imposter->size;

    glUseProgram (shader->program);
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, framedata->viewproj.p);
    glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
}
