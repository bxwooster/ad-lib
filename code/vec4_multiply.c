vec4
vec4_multiply (
        mat4 const * m,
        vec4 const * v
) {
    vec4 out = {0};

    for (int j = 0; j < 4; ++j) { /* rows */
        for (int k = 0; k < 4; ++k) {
            out.p[j] += m->p[k * 4 + j] * v->p[k];
        }
    }

    return out;
}
