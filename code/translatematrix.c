void translatematrix (float matrix [4 * 4], float move [3]) {
	float mtra [16] = {0};
	mtra[0] = mtra[5] = mtra[10] = 1.0f;
	memcpy (mtra + 12,  move, 3 * sizeof(float));
	mtra[15] = 1.0f;

	multiplymatrix (matrix, mtra);
}

