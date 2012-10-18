#pragma once
#include <vec4.h>
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

