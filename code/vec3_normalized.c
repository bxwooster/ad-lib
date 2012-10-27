vec3
vec3_normalized (
        vec3 const * v
) {
	float len = vec3_length (v);
    assert (len != 0.0f);
    return vec3_scaled (v, 1.0f / len);
}

