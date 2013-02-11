void
planet_draw (
        struct planet_DD const * data,
        struct planeta_glts const * glts,
        struct GL * gl
) {
    glUniformMatrix4fv (glts->Umvp, 1, GL_FALSE, data->mvp.p);
    glUniformMatrix4fv (glts->Umv, 1, GL_FALSE, data->mv.p);
    glUniform1f (glts->Udepth, data->depth);
    glUniform1f (glts->Uuvscale, data->uvscale);
    glUniform1i (glts->Utexture, data->texture);
    glUniform3fv (glts->Ucolour, 1, data->colour.p);

    glDrawArrays (GL_TRIANGLES, 0, gl->vertices);
}


