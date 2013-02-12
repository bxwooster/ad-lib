void moduleC (
        struct stone_engine * E
) {
    struct glts_planeta const * shader = E->glts + 3;

    glUseProgram (shader->program);
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    {
        mat4 matrix = mat4_identity ();
        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, matrix.p);

        glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
    }
}
