void vectornormalize (float v [3]) {
	float len = vectorlength(v);

	v[0] /= len;
	v[1] /= len;
	v[2] /= len;
}

