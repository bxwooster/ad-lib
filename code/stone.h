struct stone_G1 {
    mat4 transform;
    float supersize;
    float size;
};

struct stone_engine {
    struct SDL * sdl;
    struct hot_player * H;
    lua_State * L;

    GLuint tex;
    struct GLvbo_and_size vsegment;
    struct GLvbo_and_size vimposter;
    struct glts_planeta gplanets [3];
    struct glts_cello gcell;

    int8_t * key;
    unsigned key_max;

    char halt;
    struct framestate * S;

};
