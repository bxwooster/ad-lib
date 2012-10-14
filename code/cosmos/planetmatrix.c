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
    mmodel->col.w [0] += planet->orbit.major * cosf (phi);
    mmodel->col.w [1] += planet->orbit.minor * sinf (phi);

    vec3 first [1];
    vec3_diff ((vec3 *) & mmodel->e[12], (vec3 *) & mcam->e[12], first);

    float p = vec3_length (first);
    float r = planet->size;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float offset = (r * r) / p;

    vec3 unitx [1] = {{1.0f, 0.0f, 0.0f}};
    vec3 unity [1] = {{0.0f, 1.0f, 0.0f}};

    vec3 second [1];
    vec3 third [1];

    if (first->x < first->y) {
        vec3_product (first, unitx, second);
    } else {
        vec3_product (first, unity, second);
    }
    vec3_product (first, second, third);

    vec3_normalize (first);
    vec3_normalize (second);
    vec3_normalize (third);

    mat4 rotation [1] = {};
    * (vec3 *) rotation->col.z = * first;
    * (vec3 *) rotation->col.x = * second;
    * (vec3 *) rotation->col.y = * third;
    rotation->e [15] = 1.0f;
    mat4_multiply (mmodel, rotation);

    memcpy (mrot, mmodel, sizeof (float) * 16);
    mrot->e [12] = mrot->e [13] = mrot->e [14] = 0.0f;

    vec3 move [1] = {{0.0f, 0.0f, -offset}};
    mat4_move (mmodel, move);
    mat4_scale (mmodel, apparent);

    *tosurface = p - r;
    *apparentratio = apparent / r;
}

