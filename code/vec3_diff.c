void vec3_diff (
		vec3 const * a,
		vec3 const * b,
		vec3 * out) {
	out->x = a->x - b->x;
	out->y = a->y - b->y;
	out->z = a->z - b->z;
}

