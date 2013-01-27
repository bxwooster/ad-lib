mat4
mat4_scaled (
        mat4 const * m,
        float scale
) {
    mat4 out = * m;

	for (int n = 0; n < 12; ++n) {
		out.p[n] *= scale;
        /* what about the 'translation' elements? */
	}

    return out;
}

