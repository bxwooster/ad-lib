void moduleC (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    struct glts_cello const * shader = E->sh_ce;

    unsigned N = 6;//(unsigned) E->time + 3;
    struct {
        float x;
        float y;
    } tris [N] [3];

    for (unsigned i = 0; i < N; ++i) {
        float b = i / (float) N * 2 * M_PI;
        float a = (i + 1) / (float) N * 2 * M_PI;
        tris[i][0].x = 0.0f;
        tris[i][0].y = 0.0f;
        tris[i][1].x = sinf (a);
        tris[i][1].y = cosf (a);
        tris[i][2].x = sinf (b);
        tris[i][2].y = cosf (b);
    };

    glBindBuffer (GL_ARRAY_BUFFER, E->cell_vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_DYNAMIC_DRAW);

    glDepthMask (GL_FALSE);
    glUseProgram (shader->program);
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    vec3 center = {0};
    vec3 colour = {0.2, 0.4, 0.6};
    glUniform3fv (shader->Ucolour, 1, colour.p);
    glUniform2fv (shader->Ucenter, 1, center.p);
    glUniform1f (shader->Uradius, 1.0f);
    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, framedata->viewproj.p);

    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glDrawArrays (GL_TRIANGLES, 0, N * 3);

    colour = (vec3){1.0, 1.0, 1.0};
    glUniform3fv (shader->Ucolour, 1, colour.p);

    glLineWidth (5.0f);
    glDisable (GL_BLEND);
    glDisable (GL_CULL_FACE);

    glDrawArrays (GL_LINE_LOOP, 0, N*3);
}
