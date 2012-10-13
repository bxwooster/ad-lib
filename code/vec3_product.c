void vec3_product (
		vec3 const * a,
		vec3 const * b,
		vec3 * out) {
	out->x = a->y * b->z - a->z * b->y;
	out->y = a->z * b->x - a->x * b->z;
	out->z = a->x * b->y - a->y * b->x;
}

