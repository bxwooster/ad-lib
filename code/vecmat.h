// vec2 //
typedef union {
    float p [2];

    struct {
        float x;
        float y;
    } element;
} vec2;

// vec3 //
typedef union {
    float p [3];

    struct {
        float x;
        float y;
        float z;
    } element;

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
    } element;

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
    } column;
} mat4;
