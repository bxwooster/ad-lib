vec3
vec3_scaled (
        vec3 const * v,
        float scale
) {
    vec3 out;

	out.p[0] = v->p[0] * scale;
	out.p[1] = v->p[1] * scale;
	out.p[2] = v->p[2] * scale;

    return out;
}

