struct bronze_G1 {
    mat4 transform;
    float supersize;
    float size;
};

typedef struct lua_State lua_State;
struct bronze_engine {
    struct SDL * sdl;
    struct hot_player * H;
    lua_State * L;

    GLuint tex;
    struct GLvbo_and_size vsector;
    struct GLvbo_and_size vimposter;
    struct glts_planeta gplanets [3];
    struct glts_sectoro gsector;

    int8_t * key;
    unsigned key_max;

    char halt;
    mat4 Sproj;
    mat4 Sviewi;
    mat4 Sviewproj;
};
