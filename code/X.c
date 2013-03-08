struct stone_engine * XE = NULL;

void X_init(struct stone_engine * E) {
    XE = E;
}

API int8_t XKeyboard (unsigned key) {
    if (key >= XE->keyboard_max) return 0;
    return XE->keyboard[key];
}

API void XSetWireframe (char show) {
    XE->show_wireframe = show;
}

API void XSetNormalview (char show) {
    XE->show_normals = show;
}

API void XHalt () {
    XE->halt = 1;
}

API void XPull (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

API void XPreSphere () {
    struct glts_planeta const * shader = XE->gplanets;

    glBindBuffer (GL_ARRAY_BUFFER, XE->imposter.vbo);
    XE->gl->vertices = XE->imposter.size;

    glDepthMask (GL_TRUE);
    glDisable (GL_BLEND);

    glUseProgram (shader->program);

    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);
}

API void XSphere (mat4 const * transform, float radius) {
    struct stone_G1 g1;
    struct stone_G2 G2;
    g1.size = radius;
    g1.transform = *transform;

    g2 (& g1, & G2);
    g3 (&G2);
}
