void moduleC (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    for (unsigned j = 0; j < E->galaxy_size; ++j) {
        struct glts_cello const * shader = E->sh_ce;

        unsigned N = 64;//(unsigned) E->time + 3;
        struct {
            float x;
            float y;
        } tris [N] [6];

        float r1 = E->gh[j].size;
        float r2 = E->gh[j].supersize;
        for (unsigned i = 0; i < N; ++i) {
            float b = i / (float) N * 2 * M_PI;
            float a = (i + 1) / (float) N * 2 * M_PI;
            tris[i][0].x = r1 * sinf (a);
            tris[i][0].y = r1 * cosf (a);
            tris[i][1].x = r2 * sinf (a);
            tris[i][1].y = r2 * cosf (a);
            tris[i][2].x = r2 * sinf (b);
            tris[i][2].y = r2 * cosf (b);
            tris[i][3].x = r1 * sinf (a);
            tris[i][3].y = r1 * cosf (a);
            tris[i][4].x = r2 * sinf (b);
            tris[i][4].y = r2 * cosf (b);
            tris[i][5].x = r1 * sinf (b);
            tris[i][5].y = r1 * cosf (b);
        };

        glBindBuffer (GL_ARRAY_BUFFER, E->cell_vbo);
        glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_DYNAMIC_DRAW);

        glDepthMask (GL_FALSE);
        glUseProgram (shader->program);
        glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
        glEnableVertexAttribArray (shader->Apos2d);

        vec3 colour = {0.5 * j, 0.4, 0.6};
        glUniform3fv (shader->Ucolour, 1, colour.p);
        glUniform1f (shader->Uradius, r2);
        mat4 mvp = mat4_multiply (framedata->viewproj.p, E->gh[j].transform.p);
        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);

        glEnable (GL_BLEND);
        glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        glDrawArrays (GL_TRIANGLES, 0, 2 * N * 3);

        colour = (vec3){1.0, 1.0, 1.0};
        glUniform3fv (shader->Ucolour, 1, colour.p);

        glLineWidth (5.0f);
        glDisable (GL_BLEND);
        glDisable (GL_CULL_FACE);

        //glDrawArrays (GL_LINE_LOOP, 0, N*3);
   }
}
