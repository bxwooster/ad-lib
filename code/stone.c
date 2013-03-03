float const k_planet_size_minifier = 0.9f;
unsigned const k_round_cell_segments = 64;

char * GPLANETS [] = {
    "data/shade/planet.glts",
    "data/shade/planet-normals.glts",
    "data/shade/planet-wireframe.glts",
};

char CELL [] = "data/shade/cell.glts";
char STATELUA [] = "lua/state.lua";
char GALAXY [] = "data/galaxy";

void stone_frame_G1 (struct stone_engine * E) {
    for (unsigned i = 0; i < E->G->size; ++i) {
        struct framestate const * S = E->S;
        struct planet const * planet = E->G->planets + i;

        if (i == 0) {
            E->G1[i].transform = mat4_identity ();
            E->G1[i].supersize = 1.0f;
        } else {
            unsigned parent = planet->where.parent_index;
            assert (parent < i);

            float float_slot = planet->where.orbit_slot +
                S->turn + S->turn_tail;

            unsigned orbit_slots = planet->where.orbit_number - 1 + 3;
            float alpha = (2.0f * M_PI * float_slot) / orbit_slots;

            float distance = E->G1[parent].size *
                (planet->where.orbit_number + 0.5f);

            vec3 offset = {{0}};
            offset.element.x = sinf (alpha) * distance;
            offset.element.y = cosf (alpha) * distance;

            E->G1[i].transform = mat4_moved
                (& E->G1[parent].transform, & offset);
            E->G1[i].supersize =
                E->G1[parent].size * 0.5 * k_planet_size_minifier;
        }

        E->G1[i].size = E->G1[i].supersize / (planet->orbit_count + 1);
    }
}

void stone_frame_G2 (struct stone_engine * E) {
    for (unsigned i = 0; i < E->G->size; ++i) {
        struct planet * P = E->G->planets + i;
        struct stone_G1 * g1 = E->G1 + i;

        mat4 mmodel = g1->transform;

        float theta = (float) ((E->S->time / P->day.period) * M_PI * 2.0);

        mat4 out = mat4_identity ();
        out.column.w.v3 = (vec3) {{0}};
        mat4 mrot = mat4_rotated_aa (& out, & P->day.axis, theta);

        vec3 first = vec3_diff (
            & mmodel.column.w.v3,
            & E->S->viewi.column.w.v3);

        float p = vec3_length (& first);
        float r = g1->size;
        float apparent = sqrtf (p * p - r * r) * r / p;
        float apparentratio = apparent / r;
        float offset = (r * r) / p;
        float tosurface = p - r;
        float hack = logf (tosurface) / 1000.0f;

        vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
        vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

        vec3 second = first.element.x < first.element.y ?
            vec3_product (& first, & unit_x) :
            vec3_product (& first, & unit_y) ;

        vec3 third = vec3_product (& first, & second);

        mat4 rotation = {.p[15] = 1.0f};
        rotation.column.z.v3 = vec3_normalized (& first);
        rotation.column.x.v3 = vec3_normalized (& second);
        rotation.column.y.v3 = vec3_normalized (& third);
        mmodel = mat4_multiply (& mmodel, & rotation);

        mrot = mat4_multiply (& mrot, & mmodel);

        vec3 move = {{0.0f, 0.0f, -offset}};
        mmodel = mat4_moved (& mmodel, & move);
        mmodel = mat4_scaled (& mmodel, apparent);

        mat4 mvp = mat4_multiply (& E->S->viewproj, & mmodel);

        struct stone_G2 * G2 = E->G2 + i;
        G2->mvp = mvp;
        G2->mv = mrot;
        G2->depth = hack;
        G2->uvscale = apparentratio;
        G2->texture = E->tex;
        G2->colour = P->colour;
    }
}

int stone_G2_cmp (void const * a, void const * b) {
    float a_depth = ((struct stone_G2 const *) a)->depth;
    float b_depth = ((struct stone_G2 const *) b)->depth;

    return (a_depth > b_depth) ? -1 : 1;
}

void stone_frame_G3 (struct stone_engine * E) {
    qsort (E->G2, E->G->size,
            sizeof (struct stone_G2), stone_G2_cmp);

    unsigned choice = 0;
    if (E->show_wireframe) {
        choice = 2;
    } else if (E->show_normals) {
        choice = 1;
    }

    struct glts_planeta const * shader = E->gplanets + choice;

    glBindBuffer (GL_ARRAY_BUFFER, E->imposter.vbo);
    E->gl->vertices = E->imposter.size;

    glDepthMask (GL_TRUE);
    glDisable (GL_BLEND);

    glUseProgram (shader->program);

    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    for (unsigned i = 0; i < E->G->size; ++i) {
        struct stone_G2 * G2 = E->G2 + i;

        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, G2->mvp.p);
        glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, G2->mv.p);
        glUniform1f (shader->Uuvscale, G2->uvscale);
        glUniform1i (shader->Utexture, G2->texture);
        glUniform3fv (shader->Ucolour, 1, G2->colour.p);

        glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
    }
}

void stone_frame_C (struct stone_engine * E) {
    struct glts_cello const * shader = & E->gcell;

    glDepthMask (GL_FALSE);
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glUseProgram (shader->program);

    srand(1); // color hack!

    for (unsigned j = 0; j < E->G->size; ++j) {
        for (unsigned k = 0; k < E->G->planets[j].orbit_count; ++k) {
            unsigned orbit_size = k + 3; //!!
            float angle = 2*M_PI / orbit_size;
            unsigned N = k_round_cell_segments / (float) orbit_size;
            struct {
                float x;
                float y;
            } tris [N] [6];

            float s1 = E->G1[j].size;
            float s2 = E->G1[j].supersize;
            float sd = (s2 - s1) / E->G->planets[j].orbit_count;
            float r1 = s1 + sd * k;
            float r2 = s1 + sd * (k + 1);
            for (unsigned i = 0; i < N; ++i) {
                float b = i / (float) N * angle;
                float a = (i + 1) / (float) N * angle;
                tris[i][0].x = r1 * sinf (a);
                tris[i][0].y = r1 * cosf (a);
                tris[i][1].x = r2 * sinf (a);
                tris[i][1].y = r2 * cosf (a);
                tris[i][2].x = r2 * sinf (b);
                tris[i][2].y = r2 * cosf (b);
                tris[i][3].x = r1 * sinf (a);
                tris[i][3].y = r1 * cosf (a);
                tris[i][4].x = r2 * sinf (b);
                tris[i][4].y = r2 * cosf (b);
                tris[i][5].x = r1 * sinf (b);
                tris[i][5].y = r1 * cosf (b);
            };

            glBindBuffer (GL_ARRAY_BUFFER, E->cell_vbo);
            glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_DYNAMIC_DRAW);

            // these two guys need to be called after glBindBuffer
            glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
            glEnableVertexAttribArray (shader->Apos2d);

            for (unsigned p = 0; p < orbit_size; ++p) {
                float posish = 0.5 + p + E->S->turn + E->S->turn_tail;

                glUniform1f (shader->Uradius_min, r1);
                glUniform1f (shader->Uradius_max, r2);

                float r = (float) rand() / (float) RAND_MAX;
                float g = (float) rand() / (float) RAND_MAX;
                float b = 2.0f - r - g;
                vec3 colour = {r, g, b};
                glUniform3fv (shader->Ucolour, 1, colour.p);

                unsigned q;
                for (q = j; q < E->G->size; q++) {
                    if (E->G->planets[q].where.parent_index == j &&
                        E->G->planets[q].where.orbit_number == k + 1 &&
                        E->G->planets[q].where.orbit_slot == p + 1) {
                        break;
                    }
                }
                if (q == E->G->size) q = j; //no-op

                mat4 transform = mat4_rotated_aa
                    (& E->G1[j].transform, & (vec3) {0,0,1}, -angle * (posish));

                mat4 cutout = mat4_inverted_rtonly (& transform);
                cutout = mat4_multiply (&cutout, & E->G1[q].transform);
                vec4 cutout_center = vec4_multiply
                    (& cutout, & (vec4) {0,0,0,1});

                mat4 mvp = mat4_multiply
                    (& E->S->viewproj, & transform);
                glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);

                glUniform1f (shader->Ucutout_radius,
                        q == j ? 0.0f : E->G1[q].supersize);
                glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);

                glDrawArrays (GL_TRIANGLES, 0, 2 * N * 3);
           }
       }
   }
}

/* hot adapter */
void galaxy_hot (void * data, char * contents) {
    struct stone_engine * E = data;
    
    free (E->G1); /* Dup. */
    free (E->G2); /* Dup. */

    if (E->G != NULL) galaxy_del (E->G); /* Dup. */
    E->G = galaxy_parse (contents);

    E->G1 = malloc (E->G->size * sizeof (struct stone_G1));
    E->G2 = malloc (E->G->size * sizeof (struct stone_G2));

    OK (E->G1 != NULL);
    OK (E->G2 != NULL);
}

void lua_hot (void * data, char * text) {
    struct stone_engine * E = data;

    int status = luaL_loadstring (E->L, text);
    if (status != 0) {
        logi ("Couldn't load file: %s", lua_tostring (E->L, -1));
    } else {
        lua_setglobal (E->L, "state");
    }
}

void cell_hot (void * data, char * text) {
    struct stone_engine * E = data;

    glDeleteProgram (E->gcell.program); /* Dup. */

    E->gcell = glts_load_cello (CELL, text);
}

void planet_hot (void * data, char * text) {
    struct stone_engine * E = *((void **) data + 0);
    struct glts_planeta * P = *((void **) data + 1);

    glDeleteProgram (P->program); /* Dup. */

    int index = P - &E->gplanets[0];
    *P = glts_load_planeta (GPLANETS[index], text);
}

API int8_t Xkeyboard (struct stone_engine * E, unsigned key) {
    if (key >= E->keyboard_max) return 0;
    return E->keyboard[key];
}

API void Xset_wireframe (struct stone_engine * E, char show) {
    E->show_wireframe = show;
}

API void Xset_normalview (struct stone_engine * E, char show) {
    E->show_normals = show;
}

API void Xhalt (struct stone_engine * E) {
    E->halt = 1;
}

struct stone_engine *
stone_init (struct GL * gl, struct SDL * sdl) {
    struct stone_engine * E = malloc (sizeof (*E));
    OK (E != NULL);
    memset (E, 0, sizeof (*E));

    E->gl = gl;
    E->sdl = sdl;
    E->H = hot_new_player ();

    E->L = luaL_newstate ();
    OK (E->L != NULL);
    luaL_openlibs (E->L); 
    lua_pushlightuserdata (E->L, E);
    lua_setglobal (E->L, "E");
    hot_pull (E->H, STATELUA, lua_hot, E, 0);

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
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    #ifndef GLES
        GLenum poly_mode = E->show_wireframe ? GL_LINE : GL_FILL;
        glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
    #endif

    GLuint error = glGetError ();
    OK_ELSE (error == 0) {
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

    lua_getglobal (E->L, "state");
    if (!lua_isnil (E->L, -1)) {
        int result = lua_pcall (E->L, 0, 0, 0);
        if (result != 0) {
            logi ("Failed to run script:\n%s", lua_tostring (E->L, -1));
        }
    }

    stone_frame_G1 (E);
    stone_frame_G2 (E);
    stone_frame_G3 (E);
    stone_frame_C (E);

    SDL_GL_SwapWindow (E->sdl->window);

    hot_check (E->H);
    
    return E->halt;
}
