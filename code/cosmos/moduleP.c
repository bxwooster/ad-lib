void moduleP (
        struct stone_engine * E
) {
    glDisable (GL_BLEND);

    qsort (E->planet_memory, E->galaxy_size, sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (E->state->show_wireframe) {
        choice = 2;
    } else if (E->state->show_normals) {
        choice = 1;
    }

    struct glts_planeta const * shader = E->sh_pl + choice;

    glBindBuffer (GL_ARRAY_BUFFER, E->imposter->vbo);
    E->gl->vertices = E->imposter->size;

    glDepthMask (GL_TRUE);
    glUseProgram (shader->program);
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        struct planet_DD * data = E->planet_memory + i;

        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, data->mvp.p);
        glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, data->mv.p);
        glUniform1f (shader->Udepth, data->depth);
        glUniform1f (shader->Uuvscale, data->uvscale);
        glUniform1i (shader->Utexture, data->texture);
        glUniform3fv (shader->Ucolour, 1, data->colour.p);

        glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
    }
}
