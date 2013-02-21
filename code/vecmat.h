typedef union {
    float p [3];

    struct {
        float x;
        float y;
        float z;
    } element;
} vec3;

typedef union {
    float p [4];

    struct {
        float x;
        float y;
        float z;
        float w;
    } element;

    vec3 v3;
} vec4;

typedef union {
    /* first and foremost,
     * this is an array */
    float p [16]; 

    struct {
        vec4 x;
        vec4 y;
        vec4 z;
        vec4 w;
    } column;
} mat4;

mat4
mat4_identity (void);

mat4
mat4_inverted_rtonly (
        mat4 const * m
);

mat4
mat4_moved (
        mat4 const * m,
        vec3 const * v
);

mat4
mat4_multiply (
        mat4 const * a,
        mat4 const * b
);

void
mat4_print (
        mat4 const * m
);

void
vec4_print (
        vec4 const * v
);

mat4
mat4_rotated_aa (
        mat4 const * m,
        vec3 const * axis,
        float angle
);

mat4
mat4_scaled (
        mat4 const * m,
        float scale
);

vec3
vec3_diff (
		vec3 const * a,
		vec3 const * b
);

float
vec3_dot (
		vec3 const * a,
		vec3 const * b
);

float
vec3_length (
        vec3 const * v
);

vec3
vec3_normalized (
        vec3 const * v
);

vec3
vec3_product (
		vec3 const * a,
		vec3 const * b
);

vec3
vec3_scaled (
        vec3 const * v,
        float scale
);

vec3
vec3_sum (
		vec3 const * a,
		vec3 const * b
);

vec4
vec4_multiply (
        mat4 const * m,
        vec4 const * v
);

