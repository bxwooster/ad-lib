void planetmatrix (
        struct planet const * planet,
        double time,
        mat4 const * mcam,
        mat4 * mmodel,
        mat4 * mrot,
        float * tosurface,
        float * apparentratio) {
    float phi = (float) ((time / planet->orbit.period) * pi () * 2.0);

    memcpy (mmodel, planet->orbit.matrix, sizeof (float) * 16);
    mmodel->column.w.element.x += planet->orbit.major * cosf (phi);
    mmodel->column.w.element.y += planet->orbit.minor * sinf (phi);

    vec3 first = vec3_diff (& mmodel->column.w.v3, & mcam->column.w.v3);

    float p = vec3_length (& first);
    float r = planet->size;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float offset = (r * r) / p;

    vec3 unitx [1] = {{{1.0f, 0.0f, 0.0f}}};
    vec3 unity [1] = {{{0.0f, 1.0f, 0.0f}}};

    vec3 second;

    if (first.element.x < first.element.y) {
        second = vec3_product (& first, unitx);
    } else {
        second = vec3_product (& first, unity);
    }

    vec3 third = vec3_product (& first, & second);

    first = vec3_normalized (& first);
    second = vec3_normalized (& second);
    third = vec3_normalized (& third);

    mat4 rotation [1] = {};
    rotation->column.z.v3 = first;
    rotation->column.x.v3 = second;
    rotation->column.y.v3 = third;
    rotation->p[15] = 1.0f;
    mat4_multiply (mmodel, rotation);

    memcpy (mrot, mmodel, sizeof (float) * 16);
    mrot->p[12] = mrot->p[13] = mrot->p[14] = 0.0f;

    vec3 move [1] = {{{0.0f, 0.0f, -offset}}};
    mat4_move (mmodel, move);
    mat4_scale (mmodel, apparent);

    *tosurface = p - r;
    *apparentratio = apparent / r;
}

