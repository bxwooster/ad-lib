struct bronze_engine * XE = NULL;

void core_init (struct bronze_engine * E) {XE = E;}

API void Pull (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

API void Halt () {
    XE->halt = 1;
}

API double Time () {
    return (double) SDL_GetTicks () / 1000;
}

API int8_t Key (unsigned key) {
    if (key >= XE->key_max) return 0;
    return XE->key[key];
}

API vec2 Pointer () {
    int x, y;
    SDL_GetMouseState (& x, & y);

    float hw = XE->sdl->width / 2;
    float hh = XE->sdl->height / 2;

    float mx = (x - hw) / hw;
    float my = (y - hh) / hw;
    
    return (vec2) {mx, my};
}

API vec3 ScreenRay (vec2 const * pointer) {
    float q = 1.0f / tanf (M_PI / 180 * k_fov / 2);
    vec4 screen = {pointer->e.x / q, -pointer->e.y / q, 1.0, 0.0};
    return vec4_multiply (& XE->Sviewi, & screen).v3;
}

API vec3 PlaneIntersection (vec3 const * C, vec3 const * V,
        vec3 const * N, vec3 const * P) {
    vec3 CmP = vec3_diff (C, P);
    float ratio = -vec3_dot (N, & CmP) / vec3_dot (N, V);
    vec3 Vr = vec3_scaled (V, ratio);
    return vec3_sum (C, & Vr);
}

API void SetCamera (mat4 const * mcam) {
    XE->Sviewi = *mcam;
    mat4 view = mat4_inverted_rtonly (mcam);
    XE->Sviewproj = mat4_multiply (& XE->Sproj, & view);
}

API void PreSegment () {
    struct glts_cello const * shader = & XE->gcell;

    glDepthMask (GL_FALSE);
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glUseProgram (shader->program);

    glBindBuffer (GL_ARRAY_BUFFER, XE->vsegment.vbo);
    // these two guys need to be called after glBindBuffer
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);
}

API void Segment (mat4 const * tMat, vec3 const * colour,
        float r1, float r2, float angsize, float angle,
        vec3 const * hole_relative, float hole_size) {
    struct glts_cello const * shader = & XE->gcell;

    unsigned M = XE->vsegment.size / 6 / (2*M_PI) * angsize;

    mat4 transform = mat4_rotated_aa
        (tMat, & (vec3) {0,0,1}, angle);

    mat4 mvp = mat4_multiply
        (& XE->Sviewproj, & transform);

    if (hole_relative != NULL) {
        mat4 inverse = mat4_inverted_rtonly (& transform);
        vec4 v4 = vec4_from3 (hole_relative);
        vec4 cutout_center = vec4_multiply (& inverse, & v4);

        glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);
    }

    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);
    glUniform1f (shader->Uangle, angsize / M);
    glUniform1f (shader->UR1, r1);
    glUniform1f (shader->UR2, r2);
    glUniform1f (shader->Ucutout_radius, hole_size);
    glUniform3fv (shader->Ucolour, 1, colour->p);

    glDrawArrays (GL_TRIANGLES, 0, M * 6);
}

API void PreSphere () {
    struct glts_planeta const * shader = XE->gplanets;

    glBindBuffer (GL_ARRAY_BUFFER, XE->vimposter.vbo);

    glDepthMask (GL_TRUE);
    glDisable (GL_BLEND);

    glUseProgram (shader->program);

    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);
}

API void Sphere (mat4 const * tMat, vec3 const * colour, float radius) {
    /* this is somewhat hacky and might need more work
     * we want to split tMat into pure translation and rotation
     * for some unknown yet reason I had to invert the rotation
     * so it looked right. Well, that's it! */
    mat4 mmodel = *tMat;
    mmodel.c.x = (vec4) {1,0,0,0};
    mmodel.c.y = (vec4) {0,1,0,0};
    mmodel.c.z = (vec4) {0,0,1,0};
    mat4 mrot = *tMat;
    mrot.c.w = (vec4) {0};
    mrot = mat4_inverted_rtonly (& mrot);

    vec3 first = vec3_diff (
        & mmodel.c.w.v3,
        & XE->Sviewi.c.w.v3);

    float p = vec3_length (& first);
    float r = radius;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float offset = (r * r) / p;

    vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
    vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

    vec3 second = first.e.x < first.e.y ?
        vec3_product (& first, & unit_x) :
        vec3_product (& first, & unit_y) ;

    vec3 third = vec3_product (& first, & second);

    mat4 rotation = {.p[15] = 1.0f};
    rotation.c.z.v3 = vec3_normalized (& first);
    rotation.c.x.v3 = vec3_normalized (& second);
    rotation.c.y.v3 = vec3_normalized (& third);
    mmodel = mat4_multiply (& mmodel, & rotation);

    mrot = mat4_multiply (& mrot, & mmodel);

    vec3 move = {{0.0f, 0.0f, -offset}};
    mmodel = mat4_moved (& mmodel, & move);

    mat4 mvp = mat4_multiply (& XE->Sviewproj, & mmodel);

    struct glts_planeta const * shader = XE->gplanets;

    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);
    glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, mrot.p);
    glUniform1f (shader->Uuvscale, apparent / r);
    glUniform1f (shader->UR, r);
    glUniform1i (shader->Utexture, XE->tex);
    glUniform3fv (shader->Ucolour, 1, colour->p);

    glDrawArrays (GL_TRIANGLES, 0, XE->vimposter.size);
}
