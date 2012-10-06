void scalematrix (float matrix [4 * 4], float scale) {
	for (int e = 0; e < 12; ++e) {
		matrix[e] *= scale;
	}
}

