void mat4_scale (mat4 * m, float scale) {
	for (int n = 0; n < 12; ++n) {
		m->p[n] *= scale;
        /* what about the 'translation' elements? */
	}
}

