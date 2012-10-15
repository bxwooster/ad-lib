void mat4_identity (mat4 * m) {
    for (int i = 0; i < 4; ++i)
        for (int j = 0; j < 4; ++j)
            m->p[i + 4 * j] = 1.0f * (i == j);
}

