// vec2 //
typedef union {
    float p [2];

    struct {
        float x;
        float y;
    } e;
} vec2;

// vec3 //
typedef union {
    float p [3];

    struct {
        float x;
        float y;
        float z;
    } e;

    vec2 v2;
} vec3;

// vec4 //
typedef union {
    float p [4];

    struct {
        float x;
        float y;
        float z;
        float w;
    } e;

    vec2 v2;
    vec3 v3;
} vec4;

// mat4 //
typedef union {
    /* first and foremost,
     * this is an array */
    float p [16]; 

    struct {
        vec4 x;
        vec4 y;
        vec4 z;
        vec4 w;
    } c;
} mat4;
