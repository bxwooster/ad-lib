void planetmatrix (
        struct planet const * planet,
        double time,
        mat4 const * mcam,
        mat4 * mmodel,
        mat4 * mrot,
        float * tosurface,
        float * apparentratio) {
    float phi = (float) ((time / planet->orbit.period) * M_PI * 2.0);

    memcpy (mmodel, planet->orbit.matrix, sizeof (float) * 16);
    mmodel->column.w.element.x += planet->orbit.major * cosf (phi);
    mmodel->column.w.element.y += planet->orbit.minor * sinf (phi);

    vec3 first [1];
    vec3_diff ((vec3 *) & mmodel->p[12], (vec3 *) & mcam->p[12], first);

    float p = vec3_length (first);
    float r = planet->size;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float offset = (r * r) / p;

    vec3 unitx [1] = {{{1.0f, 0.0f, 0.0f}}};
    vec3 unity [1] = {{{0.0f, 1.0f, 0.0f}}};

    vec3 second [1];
    vec3 third [1];

    if (first->element.x < first->element.y) {
        vec3_product (first, unitx, second);
    } else {
        vec3_product (first, unity, second);
    }
    vec3_product (first, second, third);

    vec3_normalize (first);
    vec3_normalize (second);
    vec3_normalize (third);

    mat4 rotation [1] = {};
    rotation->column.z.v3 = * first;
    rotation->column.x.v3 = * second;
    rotation->column.y.v3 = * third;
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

