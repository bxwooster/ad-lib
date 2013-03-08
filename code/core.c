struct stone_engine * XE = NULL;

void core_init(struct stone_engine * E) {
    XE = E;
}

API int8_t Keyboard (unsigned key) {
    if (key >= XE->keyboard_max) return 0;
    return XE->keyboard[key];
}

API void Halt () {
    XE->halt = 1;
}

API void Pull (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

API void PreSegment () {
    struct glts_cello const * shader = & XE->gcell;

    glDepthMask (GL_FALSE);
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glUseProgram (shader->program);

    glBindBuffer (GL_ARRAY_BUFFER, XE->segment.vbo);
    // these two guys need to be called after glBindBuffer
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);
}

API void Segment (mat4 * tmat, float r1, float r2, float angsize, float angle,
        vec3 const * hole_relative, float hole_size) {
    struct glts_cello const * shader = & XE->gcell;

    unsigned M = XE->segment.size / 6 / (2*M_PI) * angsize;

    float r = (float) rand() / (float) RAND_MAX;
    float g = (float) rand() / (float) RAND_MAX;
    float b = (float) rand() / (float) RAND_MAX;
    vec3 colour = {r, g, b};
    glUniform3fv (shader->Ucolour, 1, colour.p);

    mat4 transform = mat4_rotated_aa
        (tmat, & (vec3) {0,0,1}, angle);
    mat4 inverse = mat4_inverted_rtonly (& transform);
    vec4 cutout_center = vec4_multiply (& inverse, hole_relative);

    mat4 mvp = mat4_multiply
        (& XE->S->viewproj, & transform);
    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);
    glUniform1f (shader->Uangle, angsize / M);
    glUniform1f (shader->UR1, r1);
    glUniform1f (shader->UR2, r2);
    glUniform1f (shader->Ucutout_radius, hole_size);
    glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);

    glDrawArrays (GL_TRIANGLES, 0, M * 6);
}

API void PreSphere () {
    struct glts_planeta const * shader = XE->gplanets;

    glBindBuffer (GL_ARRAY_BUFFER, XE->imposter.vbo);

    glDepthMask (GL_TRUE);
    glDisable (GL_BLEND);

    glUseProgram (shader->program);

    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);
}

API void Sphere (mat4 const * tmat, float radius) {
    struct stone_G1 G1;
    struct stone_G2 G2;
    G1.size = radius;
    G1.transform = *tmat;

    old_g2 (& G1, & G2);
    old_planet (& G2);
}
