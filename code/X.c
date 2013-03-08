static struct stone_engine * XE = NULL;

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
    g1.size = 2 * radius;
    g1.transform = *transform;

    g2 (& g1, & G2);
    g3 (&G2);
}

void g1 (struct planet const * planet, struct stone_G1 * G1) {
    struct framestate const * S = XE->S;
    if (planet == &XE->G->planets[0]) {
        G1->transform = mat4_identity ();
        G1->supersize = 1.0f;
    } else {
        unsigned parent = planet->where.parent_index;

        float float_slot = planet->where.orbit_slot +
            S->turn + S->turn_tail;

        unsigned orbit_slots = planet->where.orbit_number - 1 + 3;
        float alpha = (2.0f * M_PI * float_slot) / orbit_slots;

        /* Buzz. Parent */
        float distance = XE->G1[parent].size *
            (planet->where.orbit_number + 0.5f);

        vec3 offset = {{0}};
        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        G1->transform = mat4_moved
            (& XE->G1[parent].transform, & offset);
        G1->supersize =
            XE->G1[parent].size * 0.5 * k_planet_size_minifier;
    }

    G1->size = G1->supersize / (planet->orbit_count + 1);
}

void g2 (struct stone_G1 * g1, struct stone_G2 * G2) {
    mat4 mmodel = g1->transform;

    /*
    float theta = (float) ((XE->S->time / P->day.period) * M_PI * 2.0);

    mat4 out = mat4_identity ();
    out.column.w.v3 = (vec3) {{0}};
    mat4 mrot = mat4_rotated_aa (& out, & P->day.axis, theta);
    */
    mat4 mrot = mat4_identity ();

    vec3 first = vec3_diff (
        & mmodel.column.w.v3,
        & XE->S->viewi.column.w.v3);

    float p = vec3_length (& first);
    float r = g1->size;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float apparentratio = apparent / r;
    float offset = (r * r) / p;

    vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
    vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

    vec3 second = first.element.x < first.element.y ?
        vec3_product (& first, & unit_x) :
        vec3_product (& first, & unit_y) ;

    vec3 third = vec3_product (& first, & second);

    mat4 rotation = {.p[15] = 1.0f};
    rotation.column.z.v3 = vec3_normalized (& first);
    rotation.column.x.v3 = vec3_normalized (& second);
    rotation.column.y.v3 = vec3_normalized (& third);
    mmodel = mat4_multiply (& mmodel, & rotation);

    mrot = mat4_multiply (& mrot, & mmodel);

    vec3 move = {{0.0f, 0.0f, -offset}};
    mmodel = mat4_moved (& mmodel, & move);
    mmodel = mat4_scaled (& mmodel, apparent);

    mat4 mvp = mat4_multiply (& XE->S->viewproj, & mmodel);

    G2->mvp = mvp;
    G2->mv = mrot;
    G2->uvscale = apparentratio;
    G2->texture = XE->tex;
    //G2->colour = P->colour;
    G2->colour = (vec3) {1.0f, 1.0f, 1.0f};
}

void g3 (struct stone_G2 * G2) {
    struct glts_planeta const * shader = XE->gplanets;

    glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, G2->mvp.p);
    glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, G2->mv.p);
    glUniform1f (shader->Uuvscale, G2->uvscale);
    glUniform1i (shader->Utexture, G2->texture);
    glUniform3fv (shader->Ucolour, 1, G2->colour.p);

    glDrawArrays (GL_TRIANGLES, 0, XE->gl->vertices);
}

API void Xstone_frame_G () {
    XPreSphere ();

    for (unsigned i = 0; i < XE->G->size; ++i) {
        g1 (XE->G->planets + i, XE->G1 + i);
        g2 (XE->G1 + i, XE->G2 + i);
        g3 (XE->G2 + i);
    }
}

API void Xstone_frame_C () {
    struct glts_cello const * shader = & XE->gcell;

    glDepthMask (GL_FALSE);
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glUseProgram (shader->program);

    srand(1); // color hack!

    for (unsigned j = 0; j < XE->G->size; ++j) {
        for (unsigned k = 0; k < XE->G->planets[j].orbit_count; ++k) {
            unsigned orbit_size = k + 3; //!!
            float angle = 2*M_PI / orbit_size;
            unsigned N = k_round_cell_segments / (float) orbit_size;
            struct {
                float x;
                float y;
            } tris [N] [6];

            float s1 = XE->G1[j].size;
            float s2 = XE->G1[j].supersize;
            float sd = (s2 - s1) / XE->G->planets[j].orbit_count;
            float r1 = s1 + sd * k;
            float r2 = s1 + sd * (k + 1);
            for (unsigned i = 0; i < N; ++i) {
                float b = i / (float) N * angle;
                float a = (i + 1) / (float) N * angle;
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

            glBindBuffer (GL_ARRAY_BUFFER, XE->cell_vbo);
            glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_DYNAMIC_DRAW);

            // these two guys need to be called after glBindBuffer
            glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
            glEnableVertexAttribArray (shader->Apos2d);

            for (unsigned p = 0; p < orbit_size; ++p) {
                float posish = 0.5 + p + XE->S->turn + XE->S->turn_tail;

                glUniform1f (shader->Uradius_min, r1);
                glUniform1f (shader->Uradius_max, r2);

                float r = (float) rand() / (float) RAND_MAX;
                float g = (float) rand() / (float) RAND_MAX;
                float b = 2.0f - r - g;
                vec3 colour = {r, g, b};
                glUniform3fv (shader->Ucolour, 1, colour.p);

                unsigned q;
                for (q = j; q < XE->G->size; q++) {
                    if (XE->G->planets[q].where.parent_index == j &&
                        XE->G->planets[q].where.orbit_number == k + 1 &&
                        XE->G->planets[q].where.orbit_slot == p + 1) {
                        break;
                    }
                }
                if (q == XE->G->size) q = j; //no-op

                mat4 transform = mat4_rotated_aa
                    (& XE->G1[j].transform, & (vec3) {0,0,1}, -angle * (posish));

                mat4 cutout = mat4_inverted_rtonly (& transform);
                cutout = mat4_multiply (&cutout, & XE->G1[q].transform);
                vec4 cutout_center = vec4_multiply
                    (& cutout, & (vec4) {0,0,0,1});

                mat4 mvp = mat4_multiply
                    (& XE->S->viewproj, & transform);
                glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);

                glUniform1f (shader->Ucutout_radius,
                        q == j ? 0.0f : XE->G1[q].supersize);
                glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);

                glDrawArrays (GL_TRIANGLES, 0, 2 * N * 3);
           }
       }
   }
}

