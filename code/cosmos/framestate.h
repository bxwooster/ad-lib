#include <mat4.h>
struct framestate {
    mat4 cam;
    mat4 ori;
    struct {
        float x;
        float y;
        int lock;
    } mouse;
    int show_wireframe;
    int show_normals;
    unsigned turn;
};
