API void test (void) {
    logi ("Yep. It works.");
}

int lunar (int argc, char * argv []) {
    (void) argc;
    (void) argv;
    lua_State * L = luaL_newstate ();

    luaL_openlibs (L);

    int status = luaL_loadfile (L, "data/lua/script.lua");
    if (status) {
        logi ("Couldn't load file: %s", lua_tostring (L, -1));
        exit(1);
    }

    lua_newtable(L);

    for (int i = 1; i <= 5; i++) {
        lua_pushnumber (L, i);
        lua_pushnumber (L, i*2);
        lua_rawset (L, -3);
    }

    lua_setglobal (L, "foo");

    int result = lua_pcall (L, 0, LUA_MULTRET, 0);
    if (result) {
        logi ("Failed to run script: %s", lua_tostring (L, -1));
        exit (1);
    }

    double sum = lua_tonumber(L, -1);
    logi ("Script returned: %.0f", sum);

    lua_pop (L, 1);
    lua_close (L);

    return 0;
}
