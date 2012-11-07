#include <mat4.h>
struct planet_draw_data { // horrible name.
    mat4 mvp;
    mat4 mv;
    float depth;
    float uvscale;
    GLuint texture;
    vec3 color;
};

