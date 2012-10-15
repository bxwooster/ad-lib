float vec3_dot (
		vec3 const * a,
		vec3 const * b) {
    return
        (a->p[0] * b->p[0]) +
        (a->p[1] * b->p[1]) +
        (a->p[2] * b->p[2]);
}

