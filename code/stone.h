struct stone_G1 {
    mat4 transform;
    float supersize;
    float size;
};

struct stone_engine {
    struct GL * gl;
    struct SDL * sdl;
    struct hot_player * H;
    lua_State * L;

    int8_t * keyboard;
    unsigned keyboard_max;

    char show_wireframe;
    char show_normals;
    char halt;

    struct galaxy * G;
    struct stone_G1 * G1;

    struct framestate * S;

    GLuint tex;
    struct GLvbo_and_size segment;
    struct GLvbo_and_size imposter;
    struct glts_planeta gplanets [3];
    struct glts_cello gcell;
};
