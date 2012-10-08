void identitymatrix (float matrix [4 * 4]) {
    for (int i = 0; i < 4; ++i)
        for (int j = 0; j < 4; ++j)
            matrix[i + 4 * j] = (i == j ? 1.0f : 0.0f);
}

