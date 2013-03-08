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

    glDrawArrays (GL_TRIANGLES, 0, XE->imposter.size);
}

API void stone_frame_G () {
    PreSphere ();

    for (unsigned i = 0; i < XE->G->size; ++i) {
        g1 (XE->G->planets + i, XE->G1 + i);
        g2 (XE->G1 + i, XE->G2 + i);
        g3 (XE->G2 + i);
    }
}

API void stone_frame_C () {
    struct glts_cello const * shader = & XE->gcell;

    PreSegment ();

    srand(1); // color hack!

    for (unsigned j = 0; j < XE->G->size; ++j) {
        for (unsigned k = 0; k < XE->G->planets[j].orbit_count; ++k) {
            unsigned orbit_size = k + 3; //!!
            unsigned M = XE->segment.size / orbit_size;
            float angle = 2*M_PI / orbit_size;
            float s1 = XE->G1[j].size;
            float s2 = XE->G1[j].supersize;
            float sd = (s2 - s1) / XE->G->planets[j].orbit_count;
            float r1 = s1 + sd * k;
            float r2 = s1 + sd * (k + 1);

            for (unsigned p = 0; p < orbit_size; ++p) {
                float posish = 0.5 + p + XE->S->turn + XE->S->turn_tail;

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

                glUniform1f (shader->Uangle, angle / M);
                glUniform1f (shader->UR1, r1);
                glUniform1f (shader->UR2, r2);
                glUniform1f (shader->Ucutout_radius,
                        q == j ? 0.0f : XE->G1[q].supersize);
                glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);

                glDrawArrays (GL_TRIANGLES, 0, 2 * M * 3);
           }
       }
   }
}


