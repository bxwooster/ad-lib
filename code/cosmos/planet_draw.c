void
planet_draw (
        struct planet_DD const * data,
        struct planeta_layout const * layout,
        struct GL * gl
) {
    (void) gl;

    glUniformMatrix4fv (layout->Umvp, 1, GL_FALSE, data->mvp.p);
    glUniformMatrix4fv (layout->Umv, 1, GL_FALSE, data->mv.p);
    glUniform1f (layout->Udepth, data->depth);
    glUniform1f (layout->Uuvscale, data->uvscale);
    glUniform1i (layout->Utexture, data->texture);
    glUniform3fv (layout->Ucolour, 1, data->colour.p);

    glDrawArrays (GL_TRIANGLES, 0, gl->vertices);
}


