void vec3_normalize (vec3 * v) {
	float len = vec3_length (v);
    vec3_scale (v, 1 / len);
}

