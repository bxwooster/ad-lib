char * func2file (char const * func) {
    char before [] = "lua/"; int B = strlen (before);
    char after [] = ".lua"; int A = strlen (after);
    int F = strlen (func); size_t len = B + F + A;

    char * file = malloc (len + 1);
    file[len] = '\0';
    memcpy (file, before, B);
    memcpy (file + B, func, F);
    memcpy (file + B + F, after, A);
    return file;
}

void lua_hot (void * data, char const * file, char const * text) {
    struct bronze_engine * E = data;

    int status = luaL_loadbuffer (E->L, text, strlen (text), file);
    if (status != 0) {
        logi ("Couldn't load luafile: %s", lua_tostring (E->L, -1));
        sleep (1);
    } else {
        bronze_pcall (E);
    }
}

struct bronze_engine *
bronze_init (struct SDL * sdl) {
    struct bronze_engine * E = malloc (sizeof (*E));
    OK (E != NULL);
    memset (E, 0, sizeof (*E));

    E->sdl = sdl;
    E->H = hot_new_player ();

    int max;
    SDL_GetKeyboardState (& max);
    E->key = malloc (max >= 512 ? max : 512);
    E->key_max = (unsigned) max;
    OK (E->key);
    memset (E->key, -1, max);

    E->L = luaL_newstate ();
    OK (E->L != NULL);
    luaL_openlibs (E->L);

	lua_getglobal (E->L, "debug");
	lua_getfield (E->L, -1, "traceback");
	E->traceback = lua_gettop (E->L);
	XE = E;

    hot_pull (E->H, "lua/Init.lua", lua_hot, E, 0);
    lua_getglobal (E->L, "Init");
    bronze_pcall (E);

    return E;
}

void bronze_pcall (struct bronze_engine * E) {
    int result = lua_pcall (E->L, 0, 0, E->traceback);
    if (result != 0) {
        logi ("Pcall failed:\n%s", lua_tostring (E->L, -1));
		lua_pop (E->L, 1);
		exit (1);
    }
}

void bronze_destroy (struct bronze_engine * E) {
    hot_del_player (E->H);
    lua_close (E->L);
    free (E->key);
    free (E);
}

void bronze_frame_input (struct bronze_engine * E) {
    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_QUIT) {
            E->halt = 1;
        }
    }

    Uint8 * keys = SDL_GetKeyboardState (NULL);
    for (unsigned i = 0; i < E->key_max && i < 500; ++i) {
        int8_t sign = keys[i] ? 1 : -1;
        int8_t mult = (sign * E->key[i]) < 0 ? 2 : 1;
        E->key[i] = sign * mult;
    }

    uint8_t mb = SDL_GetMouseState (NULL, NULL);
    for (unsigned i = 501; i <= 503; ++i) {
        int8_t sign = (mb & SDL_BUTTON (i - 500)) ? 1 : -1;
        int8_t mult = (sign * E->key[i]) < 0 ? 2 : 1;
        E->key[i] = sign * mult;
    }

	SDL_Keymod kmods [] = {
		KMOD_LSHIFT, 
		KMOD_RSHIFT,
		KMOD_LSHIFT | KMOD_RSHIFT
	};
	SDL_Keymod mods = SDL_GetModState ();
	for (unsigned i = 504; i <= 506; ++i) {
		int8_t sign = mods & kmods[i - 504] ? 1 : -1;
		int8_t mult = (sign * E->key[i]) < 0 ? 2 : 1;
		E->key[i] = sign * mult;
	}
}

char bronze_frame (struct bronze_engine * E) {
    bronze_frame_input (E);

    lua_getglobal (E->L, "Loop");
    bronze_pcall (E);
    SDL_GL_SwapWindow (E->sdl->window);
    hot_check (E->H);
    return E->halt;
}
