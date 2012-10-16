mat4 mat4_moved (mat4 const * m, vec3 const * v) {
	mat4 mtra = mat4_identity ();
    mtra.column.w.v3 = *v;
	return mat4_multiply (m, & mtra);
}

