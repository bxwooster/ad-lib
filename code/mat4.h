typedef union {
    float e [16]; 

    struct {
        float x [4];
        float y [4];
        float z [4];
        float w [4];
    } col;
} mat4;

