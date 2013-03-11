mat4 mat4_identity (void) {
    mat4 out = {{
        1.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f,
    }};

    return out;
}

mat4 mat4_inverted_rtonly (mat4 const * m) {
    mat4 out;

    out.p[0] = m->p[0];
    out.p[5] = m->p[5];
    out.p[10] = m->p[10];

    out.p[4] = m->p[1];
    out.p[8] = m->p[2];
    out.p[9] = m->p[6];

    out.p[1] = m->p[4];
    out.p[2] = m->p[8];
    out.p[6] = m->p[9];

    float x = -m->p[12];
    float y = -m->p[13];
    float z = -m->p[14];

    out.p[12] = (out.p[0]) * x + (out.p[4]) * y + (out.p[ 8]) * z;
    out.p[13] = (out.p[1]) * x + (out.p[5]) * y + (out.p[ 9]) * z;
    out.p[14] = (out.p[2]) * x + (out.p[6]) * y + (out.p[10]) * z;

    out.p[3] = 0.0f;
    out.p[7] = 0.0f;
    out.p[11] = 0.0f;
    out.p[15] = 1.0f;

    return out;
}

mat4 mat4_moved (mat4 const * m, vec3 const * v) {
    mat4 mtra = mat4_movement (v);
	return mat4_multiply (m, & mtra);
}

mat4 mat4_movement (vec3 const * v) {
	mat4 mtra = mat4_identity ();
    mtra.c.w.v3 = *v;
    return mtra;
}

mat4 mat4_multiply (mat4 const * a, mat4 const * b) {
    mat4 out;

    for (int i = 0; i < 4; ++i) { /* columns */
        for (int j = 0; j < 4; ++j) { /* rows */
            float * s = & out.p[i * 4 + j];
            *s = 0.0f;
            for (int k = 0; k < 4; ++k) {
                *s += a->p[k * 4 + j] * b->p[i * 4 + k];
            }
        }
    }

    return out;
}

mat4 mat4_rotation_aa (vec3 const * axis, float angle) {
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

        0.0f, 0.0f, 0.0f, 1.0f
	}};

    return mrot;
}

mat4 mat4_rotated_aa (mat4 const * m, vec3 const * axis, float angle) {
    mat4 mrot = mat4_rotation_aa (axis, angle);
	return mat4_multiply (m, & mrot);
}

#define VEC4_FMT "(%.3f, %.3f, %.3f, %.3f)"
#define VEC3_FMT "(%.3f, %.3f, %.3f)"
#define VEC2_FMT "(%.3f, %.3f)"

void mat4_print (mat4 const * m) {
    for (unsigned i = 0; i < 4; ++i) {
        logi (VEC4_FMT,
                m->p[i + 0], m->p[i + 4],
                m->p[i + 8], m->p[i + 12]);
    }
}

void vec4_print (vec4 const * v) {
    logi (VEC4_FMT, v->p[0], v->p[1], v->p[2], v->p[3]);
}

void vec3_print (vec3 const * v) {
    logi (VEC3_FMT, v->p[0], v->p[1], v->p[2]);
}

void vec2_print (vec2 const * v) {
    logi (VEC2_FMT, v->p[0], v->p[1]);
}

vec4 vec4_multiply (mat4 const * m, vec4 const * v) {
    vec4 out = {0};

    for (int j = 0; j < 4; ++j) { /* rows */
        for (int k = 0; k < 4; ++k) {
            out.p[j] += m->p[k * 4 + j] * v->p[k];
        }
    }

    return out;
}

vec3 vec3_diff (vec3 const * a, vec3 const * b) {
    vec3 out;

	out.p[0] = a->p[0] - b->p[0];
	out.p[1] = a->p[1] - b->p[1];
	out.p[2] = a->p[2] - b->p[2];

    return out;
}

float vec3_dot (vec3 const * a, vec3 const * b) {
    return
        (a->p[0] * b->p[0]) +
        (a->p[1] * b->p[1]) +
        (a->p[2] * b->p[2]);
}

float vec3_length (vec3 const * v) {
	return sqrtf (vec3_dot (v, v));
}

vec3 vec3_normalized (vec3 const * v) {
	float len = vec3_length (v);
    if (len == 0.0f) return (vec3) {0, 0, 0};
    return vec3_scaled (v, 1.0f / len);
}

vec3 vec3_product (vec3 const * a, vec3 const * b) {
    vec3 out;

	out.p[0] = a->p[1] * b->p[2] - a->p[2] * b->p[1];
	out.p[1] = a->p[2] * b->p[0] - a->p[0] * b->p[2];
	out.p[2] = a->p[0] * b->p[1] - a->p[1] * b->p[0];

    return out;
}

vec3 vec3_scaled (vec3 const * v, float scale) {
    vec3 out;

	out.p[0] = v->p[0] * scale;
	out.p[1] = v->p[1] * scale;
	out.p[2] = v->p[2] * scale;

    return out;
}

vec3 vec3_sum (vec3 const * a, vec3 const * b) {
    vec3 out;

	out.p[0] = a->p[0] + b->p[0];
	out.p[1] = a->p[1] + b->p[1];
	out.p[2] = a->p[2] + b->p[2];

    return out;
}

vec3 vec3_new (float x, float y, float z) {
    vec3 out;

    out.p[0] = x;
    out.p[1] = y;
    out.p[2] = z;

    return out;
}

vec3 vec3_random (char octant) {
    for (;;) {
        double x = rand () / (double) RAND_MAX;
        double y = rand () / (double) RAND_MAX;
        double z = rand () / (double) RAND_MAX;

        if (!octant) {
            x = 2 * x - 1;
            y = 2 * y - 1;
            z = 2 * z - 1;
        }

        double r2 = x*x + y*y + z*z;
        if (r2 <= 1) {
            double r = sqrtf (r2);
            return (vec3) {x / r, y / r, z / r};
        }
    }
    return (vec3) {};
}

vec2 vec2_diff (vec2 const * a, vec2 const * b) {
    vec2 out;

	out.p[0] = a->p[0] - b->p[0];
	out.p[1] = a->p[1] - b->p[1];

    return out;
}

float vec2_dot (vec2 const * a, vec2 const * b) {
    return
        (a->p[0] * b->p[0]) +
        (a->p[1] * b->p[1]);
}

float vec2_length (vec2 const * v) {
	return sqrtf (vec2_dot (v, v));
}

vec2 vec2_normalized (vec2 const * v) {
	float len = vec2_length (v);
    if (len == 0.0f) return (vec2) {0, 0};
    return vec2_scaled (v, 1.0f / len);
}

vec2 vec2_scaled (vec2 const * v, float scale) {
    vec2 out;

	out.p[0] = v->p[0] * scale;
	out.p[1] = v->p[1] * scale;

    return out;
}

vec2 vec2_sum (vec2 const * a, vec2 const * b) {
    vec2 out;

	out.p[0] = a->p[0] + b->p[0];
	out.p[1] = a->p[1] + b->p[1];

    return out;
}

vec2 vec2_new (float x, float y) {
    vec2 out;

    out.p[0] = x;
    out.p[1] = y;

    return out;
}

vec2 vec2_random (char octant) {
    for (;;) {
        double x = rand () / (double) RAND_MAX;
        double y = rand () / (double) RAND_MAX;

        if (!octant) {
            x = 2 * x - 1;
            y = 2 * y - 1;
        }

        double r2 = x*x + y*y;
        if (r2 <= 1) {
            double r = sqrtf (r2);
            return (vec2) {x / r, y / r};
        }
    }
    return (vec2) {};
}

vec4 vec4_from3 (vec3 const * v3) {
    vec4 out;

    out.v3 = *v3;
    out.p[3] = 1.0f;

    return out;
}

vec4 vec4_from2 (vec2 const * v2) {
    vec4 out;

    out.v2 = *v2;
    out.p[2] = 0.0f;
    out.p[3] = 1.0f;

    return out;
}

vec3 vec3_from2 (vec2 const * v2) {
    vec3 out;

    out.v2 = *v2;
    out.p[2] = 0.0f;

    return out;
}
