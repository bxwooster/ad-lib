void old_g1 (struct planet const * planet, struct stone_G1 * G1) {
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

API void stone_frame_G () {
    PreSphere ();

    for (unsigned i = 0; i < XE->G->size; ++i) {
        old_g1 (XE->G->planets + i, XE->G1 + i);
        Sphere (& XE->G1[i].transform, & (vec3) {1,1,1}, XE->G1[i].size);
    }
}

API void stone_frame_C () {
    PreSegment ();

    srand(1); // color hack!

    for (unsigned j = 0; j < XE->G->size; ++j) {
        for (unsigned k = 0; k < XE->G->planets[j].orbit_count; ++k) {
            unsigned orbit_size = k + 3;
            float s1 = XE->G1[j].size;
            float s2 = XE->G1[j].supersize;
            float sd = (s2 - s1) / XE->G->planets[j].orbit_count;

            float r1 = s1 + sd * k;
            float r2 = s1 + sd * (k + 1);
            float angsize = 2*M_PI / orbit_size;

            mat4 * tmat = & XE->G1[j].transform;

            for (unsigned p = 0; p < orbit_size; ++p) {
                unsigned q;
                for (q = j; q < XE->G->size; q++) {
                    if (XE->G->planets[q].where.parent_index == j &&
                        XE->G->planets[q].where.orbit_number == k + 1 &&
                        XE->G->planets[q].where.orbit_slot == p + 1) {
                        break;
                    }
                }
                if (q == XE->G->size) q = j; //no-op

                mat4 * parent = & XE->G1[q].transform;
                vec4 hole_center = vec4_multiply (parent, & (vec4) {0,0,0,1});
                float hole_size = q == j ? 0.0f : XE->G1[q].supersize;

                float posish = 0.5 + p + XE->S->turn + XE->S->turn_tail;
                float angle = -angsize * posish;

                Segment (tmat, & (vec3) {1,1,1}, r1, r2, angsize, angle,
                        & hole_center.v3, hole_size);
           }
       }
   }
}
