void
planet_draw (
        struct planet_DD const * data,
        struct cosmosA_layout const * layout,
        struct GL * gl
) {
    (void) gl;

    glUniformMatrix4fv (layout->U.mvp, 1, GL_FALSE, data->mvp.p);
    glUniformMatrix4fv (layout->U.mv, 1, GL_FALSE, data->mv.p);
    glUniform1f (layout->U.depth, data->depth);
    glUniform1f (layout->U.uvscale, data->uvscale);
    glUniform1i (layout->Utexture, data->texture);
    glUniform3fv (layout->U.colour, 1, data->colour.p);

    glDrawArrays (GL_TRIANGLES, 0, gl->vertices);
}


