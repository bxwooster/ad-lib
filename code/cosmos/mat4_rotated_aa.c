mat4
mat4_rotated_aa (
        mat4 const * m,
        vec3 const * axis,
        float angle
) {
/*    vec3 axis_n = vec3_normalized (axis);

    float x = axis_n.p[0];
    float y = axis_n.p[1];
    float z = axis_n.p[2];*/
          float len = vec3_length (axis);
            assert (len != 0.0f);
         
                    float x = axis->p[0] / len;
                float y = axis->p[1] / len;
                 float z = axis->p[2] / len;
               

	float c = cosf (angle);
	float s = sinf (angle);

	float cc = 1.0f - c;
	float xs = x * s;
	float ys = y * s;
	float zs = z * s;

	mat4 mrot = {{
		x*x * cc + c,
		y*x * cc + zs,
		z*x * cc - ys,
		0.0f,

		x*y * cc - zs,
		y*y * cc + c,
		z*y * cc + xs,
		0.0f,

		x*z * cc + ys,
		y*z * cc - xs,
		z*z * cc + c,
		0.0f,

        0.0f,
        0.0f,
        0.0f,
        1.0f
	}};

	return mat4_multiply (m, & mrot);
}

