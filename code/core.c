struct stone_engine * XE = NULL;

void core_init (struct stone_engine * E) {XE = E;}

API void Pull (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

API void Halt () {
    XE->halt = 1;
}

API double Time () {
    return XE->S->time;
}

API double DTime () {
    return XE->S->dt;
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

API vec2 DPointer () {
    vec2 p = Pointer ();
    return vec2_diff (& p, & XE->S->pointer);
}

API void SetCamera (mat4 const * mcam) {
    XE->S->viewi = *mcam;
    mat4 view = mat4_inverted_rtonly (mcam);
    XE->S->viewproj = mat4_multiply (& XE->S->proj, & view);
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

API void Segment (mat4 const * tmat, vec3 const * colour,
        float r1, float r2, float angsize, float angle,
        vec3 const * hole_relative, float hole_size) {
    struct glts_cello const * shader = & XE->gcell;

    unsigned M = XE->vsegment.size / 6 / (2*M_PI) * angsize;

    mat4 transform = mat4_rotated_aa
        (tmat, & (vec3) {0,0,1}, angle);

    mat4 mvp = mat4_multiply
        (& XE->S->viewproj, & transform);

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

API void Sphere (mat4 const * tmat, vec3 const * colour, float radius) {
    mat4 mmodel = *tmat;
    mat4 mrot = mat4_identity ();

    vec3 first = vec3_diff (
        & mmodel.c.w.v3,
        & XE->S->viewi.c.w.v3);

    float p = vec3_length (& first);
    float r = radius;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float apparentratio = apparent / r;
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
    // scaling!
	for (int n = 0; n < 12; ++n) {
		mmodel.p[n] *= apparent;
    }

    mat4 mvp = mat4_multiply (& XE->S->viewproj, & mmodel);

    struct glts_planeta const * shader = XE->gplanets;

    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);
    glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, mrot.p);
    glUniform1f (shader->Uuvscale, apparentratio);
    glUniform1i (shader->Utexture, XE->tex);
    glUniform3fv (shader->Ucolour, 1, colour->p);

    glDrawArrays (GL_TRIANGLES, 0, XE->vimposter.size);
}
