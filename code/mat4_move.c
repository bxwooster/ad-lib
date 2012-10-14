void mat4_move (mat4 * m, vec3 const * v) {
	mat4 mtra [1];
    mat4_identity (mtra);
    * (vec3 *) mtra->col.w = * v;

	mat4_multiply (m, mtra);
}

