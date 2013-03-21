typedef struct lua_State lua_State;
struct bronze_engine {
    struct SDL * sdl;
    struct hot_player * H;
    lua_State * L;

    int8_t * key;
    unsigned key_max;

    char halt;
};
