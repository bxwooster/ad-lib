void mat4_move (mat4 * m, vec3 const * v) {
	mat4 mtra [1];
    mat4_identity (mtra);
    mtra->column.w.v3 = *v;
	mat4_multiply (m, mtra);
}

