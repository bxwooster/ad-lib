void
planet_draw (
        struct planet_DD const * data,
        struct planet_layout const * layout,
        struct GL * gl
) {
    (void) gl;

    glUniformMatrix4fv (layout->mvp, 1, GL_FALSE, data->mvp.p);
    glUniformMatrix4fv (layout->mv, 1, GL_FALSE, data->mv.p);
    glUniform1f (layout->depth, data->depth);
    glUniform1f (layout->uvscale, data->uvscale);
    glUniform1i (layout->texture, data->texture);
    glUniform3fv (layout->colour, 1, data->colour.p);

    glDrawArrays (GL_TRIANGLES, 0, gl->vertices);
}


