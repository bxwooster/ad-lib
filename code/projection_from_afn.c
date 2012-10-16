mat4 projection_from_afn (
		float aspect_ratio,
		float fov_horizontal_in_degrees,
		float near_plane_distance) {
    mat4 out;

	float q = 1 / tanf (pi () / 180 / 2 * fov_horizontal_in_degrees);

	out.p[0] = q;
	out.p[1] = 0.0f;
	out.p[2] = 0.0f;
	out.p[3] = 0.0f;

	out.p[4] = 0.0f;
	out.p[5] = q * aspect_ratio;
	out.p[6] = 0.0f;
	out.p[7] = 0.0f;
	
	out.p[8] = 0.0f;
	out.p[9] = 0.0f;
	out.p[10] = 1.0f;
	out.p[11] = 1.0f;

	out.p[12] = 0.0f;
	out.p[13] = 0.0f;
	out.p[14] = -2.0f * near_plane_distance;
	out.p[15] = 0.0f;

    return out;
}

