mat4
mat4_multiply (
        mat4 const * a,
        mat4 const * b
) {
    mat4 out;

    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            float * s = & out.p[i * 4 + j];
            *s = 0.0f;
            for (int k = 0; k < 4; ++k) {
                *s += a->p[k * 4 + j] * b->p[i * 4 + k];
            }
        }
    }

    return out;
}

