void mat4_scale (mat4 * m, float scale) {
	for (int p = 0; p < 12; ++p) {
		m->e [p] *= scale;
        /* what about the 'translation' elements? */
	}
}

