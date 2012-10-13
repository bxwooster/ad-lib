void rotatematrix (float matrix [4 * 4], float angle, vec3 * axis) {
	float len = vec3_length (axis);
	if (len == 0.0f) return;

	float x = axis->x / len;
	float y = axis->y / len;
	float z = axis->z / len;

	float c = cosf (angle);
	float s = sinf (angle);

	float cc = 1.0f - c;
	float xs = x * s;
	float ys = y * s;
	float zs = z * s;

	float mrot [16] = {
		x*x * cc + c,
		y*x * cc + zs,
		z*x * cc - ys,
		0.0f,

		x*y * cc - zs,
		y*y * cc + c,
		z*y * cc + xs,
		0.0f,

		x*z * cc + ys,
		y*z * cc - xs,
		z*z * cc + c,
		0.0f,

		0.0f, 0.0f, 0.0f, 1.0f
	};

	multiplymatrix (matrix, mrot);
}

