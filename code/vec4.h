#pragma once
#include <vec3.h>
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

