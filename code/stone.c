float const k_planet_size_minifier = 0.9f;

char * GPLANETS [] = {
    "glsl/planet.glts",
    "glsl/planet-normals.glts",
    "glsl/planet-wireframe.glts",
};

char CELL [] = "glsl/cell.glts";
char GALAXY [] = "data/galaxy";

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

    
/* hot adapter */
void galaxy_hot (void * data, char const * file, char const * text) {
    struct stone_engine * E = data;
    (void) file;

    free (E->G1); /* Dup. */

    if (E->G != NULL) galaxy_del (E->G); /* Dup. */
    E->G = galaxy_parse (text);

    E->G1 = malloc (E->G->size * sizeof (struct stone_G1));
    OK (E->G1 != NULL);
}

void lua_hot (void * data, char const * file, char const * text) {
    struct stone_engine * E = data;

    int status = luaL_loadbuffer (E->L, text, strlen (text), file);
    if (status != 0) {
        logi ("Couldn't load luafile: %s", lua_tostring (E->L, -1));
        sleep (1);
    } else {
        stone_pcall (E);
    }
}

void cell_hot (void * data, char const * file, char const * text) {
    struct stone_engine * E = data;
    (void) file;

    glDeleteProgram (E->gcell.program); /* Dup. */

    E->gcell = glts_load_cello (CELL, (char /*const*/ *) text);
}

void planet_hot (void * data, char const * file, char const * text) {
    struct stone_engine * E = *((void **) data + 0);
    struct glts_planeta * P = *((void **) data + 1);
    (void) file;

    glDeleteProgram (P->program); /* Dup. */

    int index = P - &E->gplanets[0];
    *P = glts_load_planeta (GPLANETS[index], (char /*const*/ *) text);
}

struct stone_engine *
stone_init (struct SDL * sdl) {
    struct stone_engine * E = malloc (sizeof (*E));
    OK (E != NULL);
    memset (E, 0, sizeof (*E));

    E->sdl = sdl;
    E->H = hot_new_player ();

    E->G = NULL;
    E->G1 = NULL;
    hot_pull (E->H, GALAXY, galaxy_hot, E, 0);

    int max;
    SDL_GetKeyboardState (& max);
    E->key = malloc (max);
    E->key_max = (unsigned) max;
    OK (E->key);
    memset (E->key, -1, max);

    E->S = state_init (E);

    E->tex = util_earth ();
    E->vsegment = util_segment ();
    E->vimposter = util_imposter ();

    for (unsigned i = 0; i < 3; ++i) {
        void * EnP [] = { E, &E->gplanets[0] + i };
        E->gplanets[i] = (struct glts_planeta) {0};
        E->gplanets[i].program = GL_FALSE;
        hot_pull (E->H, GPLANETS[i], planet_hot, EnP, sizeof (EnP));
    }

    E->gcell = (struct glts_cello) {0};
    E->gcell.program = GL_FALSE;
    hot_pull (E->H, CELL, cell_hot, E, 0);

    core_init (E);
    E->L = luaL_newstate ();
    OK (E->L != NULL);
    luaL_openlibs (E->L);
    lua_pushlightuserdata (E->L, E);
    lua_setglobal (E->L, "_E");
    hot_pull (E->H, "lua/Init.lua", lua_hot, E, 0);
    lua_getglobal (E->L, "Init");
    stone_pcall (E);

    return E;
}

void stone_pcall (struct stone_engine * E) {
    int result = lua_pcall (E->L, 0, 0, 0);
    if (result != 0) {
        logi ("Pcall failed:\n%s", lua_tostring (E->L, -1));
        sleep (1);
    }
}

void stone_destroy (struct stone_engine * E) {
    free (E->G1);
    galaxy_del (E->G);
    state_del (E->S);
    hot_del_player (E->H);
    lua_close (E->L);
    free (E->key);

    glDeleteBuffers (1, & E->vsegment.vbo);
    glDeleteBuffers (1, & E->vimposter.vbo);
    glDeleteTextures (1, & E->tex);

    for (unsigned i = 0; i < 3; ++i) {
        glDeleteProgram (E->gplanets[i].program);
    }

    glDeleteProgram (E->gcell.program);

    free (E);
}

void stone_frame_gl (struct stone_engine * E) {
    glActiveTexture (GL_TEXTURE0); glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, E->sdl->width, E->sdl->height);

    glDepthMask (GL_TRUE);
    glClearColor (1.0f, 1.0f, 1.0f, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    GLuint error = glGetError ();
    if (error != 0) {
        logi ("There occurred a GL error, # %d.", error);
    }
}

void stone_frame_input (struct stone_engine * E) {
    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_QUIT) {
            E->halt = 1;
        }
    }

    uint8_t mb = SDL_GetMouseState (NULL, NULL);
    for (unsigned i = 1; i <= 3; ++i) {
        int8_t sign = (mb & SDL_BUTTON (i)) ? 1 : -1;
        int8_t mult = (sign * E->key[i]) < 0 ? 2 : 1;
        E->key[i] = sign * mult;
    }

    Uint8 * keys = SDL_GetKeyboardState (NULL);
    for (unsigned i = 4; i < E->key_max; ++i) {
        int8_t sign = keys[i] ? 1 : -1;
        int8_t mult = (sign * E->key[i]) < 0 ? 2 : 1;
        E->key[i] = sign * mult;
    }
}

char stone_frame (struct stone_engine * E) {
    stone_frame_gl (E);
    stone_frame_input (E);

    state_advance (E);

    lua_getglobal (E->L, "Loop");
    stone_pcall (E);

    SDL_GL_SwapWindow (E->sdl->window);
    hot_check (E->H);
    return E->halt;
}
