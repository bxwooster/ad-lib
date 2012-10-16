vec3 vec3_product (
		vec3 const * a,
		vec3 const * b) {
    vec3 out;

	out.p[0] = a->p[1] * b->p[2] - a->p[2] * b->p[1];
	out.p[1] = a->p[2] * b->p[0] - a->p[0] * b->p[2];
	out.p[2] = a->p[0] * b->p[1] - a->p[1] * b->p[0];

    return out;
}

