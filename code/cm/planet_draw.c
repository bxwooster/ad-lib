void
planet_draw (
        int vertices,
        struct planet_draw_data const * data,
        struct planet_draw_GLdata const * GLdata,
        struct GL * gl
) {
    (void) gl;

    glUniformMatrix4fv (GLdata->mvp, 1, GL_FALSE, data->mvp.p);
    glUniformMatrix4fv (GLdata->mv, 1, GL_FALSE, data->mv.p);
    glUniform1f (GLdata->depth, data->depth);
    glUniform1f (GLdata->uvscale, data->uvscale);
    glUniform1i (GLdata->texture, data->texture);
    glUniform3fv (GLdata->color, 1, data->color.p);

    glDrawArrays (GL_TRIANGLES, 0, vertices);
}


