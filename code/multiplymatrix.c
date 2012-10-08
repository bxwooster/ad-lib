void multiplymatrix (float matrix [4 * 4], float another [4 * 4]) {
    /* note: breaks when matrix == another */
    float * a = matrix;
    float * b = another;
    float c [4 * 4]; /* transposed copy of A */

    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            c[j * 4 + i] = a[i * 4 + j];
        }
    }

    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            float * f = &a[i * 4 + j];
            *f = 0.0f;
            for (int k = 0; k < 4; ++k) {
                *f += c[j * 4 + k] * b[i * 4 + k];
            }
        }
    }
            
}


