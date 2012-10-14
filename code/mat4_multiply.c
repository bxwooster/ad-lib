void mat4_multiply (mat4 * a, mat4 const * b) {
    assert (a != b);

    mat4 c [1]; /* transposed copy of A */
    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            c->e [j * 4 + i] = a->e [i * 4 + j];
        }
    }

    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            float * s = & a->e [i * 4 + j];
            * s = 0.0f;
            for (int k = 0; k < 4; ++k) {
                * s += c->e [j * 4 + k] * b->e [i * 4 + k];
            }
        }
    }
}

