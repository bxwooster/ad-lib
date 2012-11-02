struct framestate {
    mat4 cam;
    mat4 ori;
    struct {
        float x;
        float y;
        int lock;
    } mouse;
};
