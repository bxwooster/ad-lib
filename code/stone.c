float const k_planet_size_minifier = 0.9f;
unsigned const k_round_cell_segments = 64;

char * GPLANETS [] = {
    "data/shade/planet.glts",
    "data/shade/planet-normals.glts",
    "data/shade/planet-wireframe.glts",
};

char CELL [] = "data/shade/cell.glts";
char GALAXY [] = "data/galaxy";

char * file2func (char const * file) {
    char const * dot = strrchr (file, '.');
    char const * afterslash = strrchr (file, '/') + 1;
    OK (dot != NULL && afterslash != NULL && dot > afterslash);
    size_t len = dot - afterslash;
    char * func = malloc (len + 1);
    func[len] = '\0';
    memcpy (func, afterslash, len);
    return func;
}

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
    free (E->G2); /* Dup. */

    if (E->G != NULL) galaxy_del (E->G); /* Dup. */
    E->G = galaxy_parse (text);

    E->G1 = malloc (E->G->size * sizeof (struct stone_G1));
    E->G2 = malloc (E->G->size * sizeof (struct stone_G2));

    OK (E->G1 != NULL);
    OK (E->G2 != NULL);
}

void lua_hot (void * data, char const * file, char const * text) {
    struct stone_engine * E = data;
    char * func = file2func (file);

    int status = luaL_loadbuffer (E->L, text, strlen (text), func);
    if (status != 0) {
        logi ("Couldn't load luafile: %s", lua_tostring (E->L, -1));
    } else {
        lua_setglobal (E->L, func);
    }
    free (func);
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
stone_init (struct GL * gl, struct SDL * sdl) {
    struct stone_engine * E = malloc (sizeof (*E));
    OK (E != NULL);
    memset (E, 0, sizeof (*E));

    E->gl = gl;
    E->sdl = sdl;
    E->H = hot_new_player ();

    E->G = NULL;
    E->G1 = NULL;
    E->G2 = NULL;
    hot_pull (E->H, GALAXY, galaxy_hot, E, 0);

    int max;
    SDL_GetKeyboardState (& max);
    E->keyboard = malloc (max);
    E->keyboard_max = (unsigned) max;
    OK (E->keyboard);
    memset (E->keyboard, -1, max);

    E->S = state_init (E);

    E->tex = util_earth ();
    glGenBuffers (1, & E->cell_vbo);
    E->imposter = util_imposter ();

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
    lua_setglobal (E->L, "E");
    hot_pull (E->H, "lua/Init.lua", lua_hot, E, 0);
    lua_getglobal (E->L, "Init");
    int result = lua_pcall (E->L, 0, 0, 0);
    if (result != 0) {
        logi ("Lua's Init failed:\n%s", lua_tostring (E->L, -1));
    }

    return E;
}

void stone_destroy (struct stone_engine * E) {
    free (E->G1);
    free (E->G2);
    galaxy_del (E->G);
    state_del (E->S);
    hot_del_player (E->H);
    lua_close (E->L);
    free (E->keyboard);

    glDeleteBuffers (1, & E->cell_vbo);
    glDeleteBuffers (1, & E->imposter.vbo);
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

    #ifndef GLES
        GLenum poly_mode = E->show_wireframe ? GL_LINE : GL_FILL;
        glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
    #endif

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

    Uint8 * keys = SDL_GetKeyboardState (NULL);
    for (unsigned i = 0; i < E->keyboard_max; ++i) {
        int8_t sign = keys[i] ? 1 : -1;
        int8_t mult = (sign * E->keyboard[i]) < 0 ? 2 : 1;
        E->keyboard[i] = sign * mult;
    }
}

char stone_frame (struct stone_engine * E) {
    stone_frame_gl (E);
    stone_frame_input (E);

    state_advance (E);

    lua_getglobal (E->L, "Loop");
    if (!lua_isnil (E->L, -1)) {
        int result = lua_pcall (E->L, 0, 0, 0);
        if (result != 0) {
            logi ("Failed to run script:\n%s", lua_tostring (E->L, -1));
        }
    }

    SDL_GL_SwapWindow (E->sdl->window);
    hot_check (E->H);
    return E->halt;
}
