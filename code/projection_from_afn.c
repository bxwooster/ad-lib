void projection_from_afn (
		float aspect_ratio,
		float fov_horizontal_in_degrees,
		float near_plane_distance,
		mat4 * out) {
	float q = 1 / tanf ((float) M_PI / 180 / 2 * fov_horizontal_in_degrees);

	out->e [0] = q;
	out->e [1] = 0.0f;
	out->e [2] = 0.0f;
	out->e [3] = 0.0f;

	out->e [4] = 0.0f;
	out->e [5] = q * aspect_ratio;
	out->e [6] = 0.0f;
	out->e [7] = 0.0f;
	
	out->e [8] = 0.0f;
	out->e [9] = 0.0f;
	out->e [10] = 1.0f;
	out->e [11] = 1.0f;

	out->e [12] = 0.0f;
	out->e [13] = 0.0f;
	out->e [14] = -2.0f * near_plane_distance;
	out->e [15] = 0.0f;
}

