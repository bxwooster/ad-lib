/* The Konstants! */
float const k_turn_transition_delay = 1.5f;
float const k_planet_size_minifier = 0.9f;
unsigned const k_round_cell_segments = 64;
float const k_camera_speed = 0.05f;

/******************************************************************************/

GLenum // GLformat
load_earth (
        SDL_Surface * earth [6],
        struct IMG * img,
        struct SDL * sdl
) {
    char const * const earthimg [6] = {
        "art/earth/posx.jpg",
        "art/earth/negx.jpg",
        "art/earth/posy.jpg",
        "art/earth/negy.jpg",
        "art/earth/posz.jpg",
        "art/earth/negz.jpg",
    };

    for (int i = 0; i < 6; ++i) {
        (void) img;
        earth[i] = IMG_Load (earthimg[i]);
        if (earth[i] == NULL) {
            logi ("SDL_image error: %s", IMG_GetError ());
            return GL_FALSE;
        }
    }

    Uint32 sdlformat = earth[0]->format->format;

    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB24) return GL_RGB;
    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB888) return GL_BGRA;

    (void) sdl;
    logi ("Unexpected texture format: %s",
        SDL_GetPixelFormatName (sdlformat)); 
    return GL_FALSE;
}

GLuint // tex
prepare_GLtex (
        SDL_Surface * earth [6],
        GLenum GLformat,
        struct GL * gl
) {
    (void) gl;
    GLuint tex;
    glGenTextures (1, &tex);
    glBindTexture (GL_TEXTURE_CUBE_MAP, tex); // ?
#ifndef GLES
    glTexEnvf(GL_TEXTURE_FILTER_CONTROL, GL_TEXTURE_LOD_BIAS, -1.75f);

    GLenum tSTR [] = {
        GL_TEXTURE_WRAP_S,
        GL_TEXTURE_WRAP_T,
        GL_TEXTURE_WRAP_R
    };
    for (int i = 0; i < 3; ++i) {
        glTexParameteri (GL_TEXTURE_CUBE_MAP, tSTR[i], GL_CLAMP_TO_EDGE);
    }
 
    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_GENERATE_MIPMAP,
        GL_TRUE);
#endif

	GLenum min_filter =
#ifndef GLES
        GL_NEAREST_MIPMAP_LINEAR;
#else
        GL_NEAREST;
#endif

    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_TEXTURE_MIN_FILTER,
        min_filter);

    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_TEXTURE_MAG_FILTER,
        GL_LINEAR);

    GLenum targets [6] = {
        GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    };

    for (int i = 0; i < 6; ++i) {
        glTexImage2D (targets[i], 0, GL_RGBA, earth[i]->w, earth[i]->h,
            0, GLformat, GL_UNSIGNED_BYTE, earth[i]->pixels);
    }

    return tex;
}

GLuint // tex
get_earth_GLtex (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
    GLuint tex = GL_FALSE;
    SDL_Surface * earth [6] = {0};

    GLenum GLformat = load_earth (earth, img, sdl);
    if (GLformat != GL_FALSE) {
        tex = prepare_GLtex (earth, GLformat, gl);
    }

    for (int i = 0; i < 6; i++) {
        SDL_FreeSurface (earth[i]);
    }

    return tex;
}

struct GLvbo_and_size
prepare_imposter (
        struct GL * gl
) {
    float const y = (float) (1.0 - sqrt(2.0));

    struct {
        float x;
        float y;
    } const tris [] [3] = {
        {{0, 0}, {+1,-y}, {+1,+y}},
        {{0, 0}, {+1,+y}, {-y,-1}},
        {{0, 0}, {-y,-1}, {+y,-1}},
        {{0, 0}, {+y,-1}, {-1,+y}},
        {{0, 0}, {-1,+y}, {-1,-y}},
        {{0, 0}, {-1,-y}, {+y,+1}},
        {{0, 0}, {+y,+1}, {-y,+1}},
        {{0, 0}, {-y,+1}, {+1,-y}},
    };
    int vertices = sizeof (tris) / sizeof (tris[0][0]);

    (void) gl;
    GLuint vbo;
    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    return (struct GLvbo_and_size) {vbo, vertices};
}

mat4
projection_from_afn (
		float aspect_ratio,
		float fov_horizontal_in_degrees,
		float near_plane_distance
) {
    mat4 out;

	float q = 1 / tanf (M_PI / 180 / 2 * fov_horizontal_in_degrees);

	out.p[0] = q;
	out.p[1] = 0.0f;
	out.p[2] = 0.0f;
	out.p[3] = 0.0f;

	out.p[4] = 0.0f;
	out.p[5] = q * aspect_ratio;
	out.p[6] = 0.0f;
	out.p[7] = 0.0f;
	
	out.p[8] = 0.0f;
	out.p[9] = 0.0f;
	out.p[10] = 1.0f;
	out.p[11] = 1.0f;

	out.p[12] = 0.0f;
	out.p[13] = 0.0f;
	out.p[14] = -2.0f * near_plane_distance;
	out.p[15] = 0.0f;

    return out;
}

mat4 // proj
standard_projection (
        unsigned width,
        unsigned height,
        float fov
) {
    float const screen_aspect = ((float) width) / height;
    return projection_from_afn (screen_aspect, fov, 0.01f);
} 

void
camera_initial (struct framestate * S) {
    mat4 one = mat4_identity ();

    vec3 move = {{0.0f, 1.7f, 1.0f}};
    S->mov = mat4_moved (& one, & move);
    
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    S->rot = mat4_rotated_aa (& one, & axis, M_PI * 0.7);
}

struct framestate
initial_framestate (void) {
    struct framestate out = {0};
    camera_initial (& out);
    out.show_normals = 1;
    return out;
}

/* hot adapter */
void galaxy_hot (void * data, char * contents) {
    struct stone_engine * E = data;
    
    free (E->gh);
    free (E->planet_memory);
    if (E->G != NULL) galaxy_del (E->G);

    E->G = galaxy_parse (contents);

    E->gh = malloc (E->G->size * sizeof (struct galaxy_helper));
    OK (E->gh != NULL);

    E->planet_memory = malloc (E->G->size * sizeof (struct planet_DD));
    OK (E->planet_memory != NULL);
}

struct stone_engine *
stone_init (struct GL * gl, struct SDL * sdl, struct IMG * img) {
    struct stone_engine * E = malloc (sizeof (*E));
    OK (E != NULL);

    E->gl = gl;
    E->sdl = sdl;

    E->H = hot_new_player ();

    char const * glts_names [] = {
        "data/shade/planet.glts",
        "data/shade/planet-normals.glts",
        "data/shade/planet-wireframe.glts",
    };
    for (unsigned i = 0; i < 3; ++i) {
        E->sh_pl[i] = glts_load_planeta (gl, glts_names[i]);
        OK (E->sh_pl[i].program != GL_FALSE);
    }

    E->sh_ce = glts_load_cello (gl, "data/shade/cell.glts");
    OK (E->sh_ce.program != GL_FALSE);

    E->tex = get_earth_GLtex (gl, sdl, img);
    OK (E->tex != GL_FALSE);

    E->imposter = prepare_imposter (gl);
    OK (E->imposter.vbo != GL_FALSE);

    glGenBuffers (1, & E->cell_vbo);
    OK (E->cell_vbo != GL_FALSE);

    float fov = 60.0f;
    E->mproj = standard_projection (sdl->width, sdl->height, fov);

    E->state = initial_framestate ();
    E->time = 0.0;

    E->gh = NULL;
    E->planet_memory = NULL;
    E->G = NULL;
    hot_pull (E->H, "data/galaxy", galaxy_hot, (void *) E);

    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, E->sdl->width, E->sdl->height);

    return E;
}

/******************************************************************************/

void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = & E->state;

    float dx = I->mouse.x - S->mouse.x;
    float dy = I->mouse.y - S->mouse.y;
    /* still something is broken with arbitrary rotations */
    dx = 0;

    if (I->mouse.buttons & SDL_BUTTON (2)) {
        S->mov.column.w.element.z *= exp(dy);
    }

    if (I->mouse.buttons & SDL_BUTTON (3)) {
        vec3 rot = {{dy, dx, 0.0f}};
        float angle = sqrt (dx*dx + dy*dy);
        if (angle > 0) {
            S->rot = mat4_rotated_aa (& S->rot, & rot, -angle);
        }
    }

    S->mouse.x = I->mouse.x;
    S->mouse.y = I->mouse.y;

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-I->mouse.x / q, I->mouse.y / q, 1.0, 0.0};
    mat4 invrot = mat4_inverted_rtonly (& S->rot);
    /* need this be inverted? */
    view = vec4_multiply (& invrot, & view);

    float ratio = S->mov.column.w.element.z / view.element.z;
    float px = view.element.x * ratio + S->mov.column.w.element.x;
    float py = view.element.y * ratio + S->mov.column.w.element.y;

    char lock = (I->mouse.buttons & SDL_BUTTON (1)) != 0;

    float delta = k_camera_speed;
    // note: need to multiply by Dt, actually
    if (I->arrows.up) S->mov.column.w.element.y -= delta;
    if (I->arrows.down) S->mov.column.w.element.y += delta;
    if (I->arrows.left) S->mov.column.w.element.x -= delta;
    if (I->arrows.right) S->mov.column.w.element.x += delta;

    if (S->lock != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        S->mov.column.w.element.x -= dx;
        S->mov.column.w.element.y -= dy;

        if (!lock) S->lock = 0;
    }
    else {
        if (lock) {
            S->lock = 1;
            S->pan.x = px;
            S->pan.y = py;

            logi ("Locked @ %f - %f", px, py);
        }
    }

    S->show_normals ^= I->toggle_normals;
    S->show_wireframe ^= I->toggle_wireframe;

    if (I->next_turn && !S->turn_transition) {
        S->turn_transition = 1;
        S->turn_transition_ends = E->time + k_turn_transition_delay;
    }

    if (S->turn_transition && E->time > S->turn_transition_ends) {
        S->turn++;
        S->turn_transition = 0;
    }
    
    S->turn_tail = 0.0f;
    if (S->turn_transition) {
        float ttd = k_turn_transition_delay;
        S->turn_tail = (E->time - S->turn_transition_ends + ttd) / ttd;
    }
}

struct galaxy_helper
galaxy_prepare (
        struct stone_engine * E,
        unsigned planet_number
) {
    struct galaxy_helper result;

    struct framestate const * S = & E->state;
    struct planet const * planet = E->G->planets + planet_number;

    if (planet_number == 0) {
        result.transform = mat4_identity ();
        result.supersize = 1.0f;
    } else {
        unsigned parent = planet->where.parent_index;
        assert (parent < planet_number);

        float float_slot = planet->where.orbit_slot +
            S->turn + S->turn_tail;

        unsigned orbit_slots = planet->where.orbit_number - 1 + 3;
        float alpha = (2.0f * M_PI * float_slot) / orbit_slots;

        float distance = E->gh[parent].size *
            (planet->where.orbit_number + 0.5f);

        vec3 offset = {{0}};
        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        result.transform = mat4_moved (& E->gh[parent].transform, & offset);
        result.supersize = E->gh[parent].size * 0.5 * k_planet_size_minifier;
    }

    result.size = result.supersize / (planet->orbit_count + 1);

    return result;
}

struct frame_DD
generate_frame_DD (
        mat4 const * proj,
        struct framestate const * S
) {
    mat4 viewi = mat4_multiply (& S->mov, & S->rot);
    mat4 view = mat4_inverted_rtonly (& viewi);
    mat4 viewproj = mat4_multiply (proj, & view);

    return (struct frame_DD) {
        viewi,
        viewproj
    };
}

mat4
planet_dayrotation (
        struct stone_engine * E,
        struct planet_day const * day
) {
    float theta = (float) ((E->time / day->period) * M_PI * 2.0);

    mat4 out = mat4_identity ();
    out.column.w.v3 = (vec3) {{0}};
    return mat4_rotated_aa (& out, & day->axis, theta);
}

struct planet_DD
generate_planet_DD (
        struct stone_engine * E,
        struct frame_DD * framedata,
        unsigned planet_number
) {
    struct galaxy_helper * helper = E->gh + planet_number;
    struct planet * planet = E->G->planets + planet_number;

    mat4 mmodel = helper->transform;
    mat4 mrot = planet_dayrotation (E, & planet->day);

    vec3 first = vec3_diff (
        & mmodel.column.w.v3,
        & framedata->viewi.column.w.v3);

    float p = vec3_length (& first);
    float r = helper->size;
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

    mat4 mvp = mat4_multiply (& framedata->viewproj, & mmodel);

    struct planet_DD data = {
        mvp,
        mrot,
        hack,
        apparentratio,
        0, // texture, not correct at all
        planet->colour
    };

    return data;
}

void
poll_SDLevents (
        struct stone_engine * E,
        struct input * currently
) {
    memset (currently, 0, sizeof (*currently));

    int x, y;
    currently->mouse.buttons = SDL_GetMouseState (& x, & y);

    float hw = E->sdl->width / 2;
    float hh = E->sdl->height / 2;

    currently->mouse.x = (x - hw) / hw;
    currently->mouse.y = (y - hh) / hw;

    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_KEYDOWN) {
            SDL_Keycode key = event.key.keysym.sym;
            if (key == SDLK_ESCAPE) {
                currently->halt = 1;
            }
            else if (key == SDLK_w) {
                currently->toggle_wireframe = 1;
            }
            else if (key == SDLK_n) {
                currently->toggle_normals = 1;
            }
            else if (key == SDLK_SPACE) {
                currently->next_turn = 1;
            }
        } else if (event.type == SDL_QUIT) {
            currently->halt = 1;
        }
    }

    Uint8 * keys = SDL_GetKeyboardState (NULL);

    currently->arrows.up = keys[SDL_SCANCODE_UP];
    currently->arrows.down = keys[SDL_SCANCODE_DOWN];
    currently->arrows.left = keys[SDL_SCANCODE_LEFT];
    currently->arrows.right = keys[SDL_SCANCODE_RIGHT];
}

void moduleB (struct stone_engine * E, struct frame_DD * framedata) {
    for (unsigned i = 0; i < E->G->size; ++i) {
        E->gh[i] = galaxy_prepare (E, i);
    }

    for (unsigned i = 0; i < E->G->size; ++i) {
        E->planet_memory[i] = generate_planet_DD (E, framedata, i);
    }
}

void moduleC (struct stone_engine * E, struct frame_DD * framedata) {
    struct glts_cello const * shader = & E->sh_ce;

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

            float s1 = E->gh[j].size;
            float s2 = E->gh[j].supersize;
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
                float posish = 0.5 + p + E->state.turn + E->state.turn_tail;

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
                    (& E->gh[j].transform, & (vec3) {0,0,1}, -angle * (posish));

                mat4 cutout = mat4_inverted_rtonly (& transform);
                cutout = mat4_multiply (&cutout, & E->gh[q].transform);
                vec4 cutout_center = vec4_multiply
                    (& cutout, & (vec4) {0,0,0,1});

                mat4 mvp = mat4_multiply
                    (& framedata->viewproj, & transform);
                glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);

                glUniform1f (shader->Ucutout_radius,
                        q == j ? 0.0f : E->gh[q].supersize);
                glUniform2fv (shader->Ucutout_center, 1, cutout_center.p);

                glDrawArrays (GL_TRIANGLES, 0, 2 * N * 3);
           }
       }
   }
}

int closest_planet_DD (void const * a, void const * b) {
    float a_depth = ((struct planet_DD const *) a)->depth;
    float b_depth = ((struct planet_DD const *) b)->depth;

    return (a_depth > b_depth) ? -1 : 1;
}

void moduleP (struct stone_engine * E) {
    qsort (E->planet_memory, E->G->size,
            sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (E->state.show_wireframe) {
        choice = 2;
    } else if (E->state.show_normals) {
        choice = 1;
    }

    struct glts_planeta const * shader = E->sh_pl + choice;

    glBindBuffer (GL_ARRAY_BUFFER, E->imposter.vbo);
    E->gl->vertices = E->imposter.size;

    glDepthMask (GL_TRUE);
    glDisable (GL_BLEND);

    glUseProgram (shader->program);

    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    for (unsigned i = 0; i < E->G->size; ++i) {
        struct planet_DD * data = E->planet_memory + i;

        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, data->mvp.p);
        glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, data->mv.p);
        glUniform1f (shader->Uuvscale, data->uvscale);
        glUniform1i (shader->Utexture, data->texture);
        glUniform3fv (shader->Ucolour, 1, data->colour.p);

        glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
    }
}

int GL_check_errors (void) {
    GLuint error = glGetError ();
    if (error != 0) {
        logi ("There occurred a GL error, # %d.", error);
        return 0;
    }

    return 1;
}

char stone_do_frame (struct stone_engine * E) {
    hot_check (E->H);

    glDepthMask (GL_TRUE);
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    #ifndef GLES
        GLenum poly_mode = E->state.show_wireframe ? GL_LINE : GL_FILL;
        glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
    #endif

    OK (GL_check_errors ());

    E->time = (double) SDL_GetTicks () / 1000;

    struct input physical;
    poll_SDLevents (E, & physical);
    if (physical.halt) return 1;

    advance_framestate (E, & physical);

    struct frame_DD framedata =
        generate_frame_DD (& E->mproj, & E->state);

    moduleB (E, & framedata);
    moduleP (E);
    moduleC (E, & framedata);

    SDL_GL_SwapWindow (E->sdl->window);

    return 0;
}

void stone_destroy (struct stone_engine * E) {
    free (E->gh);
    free (E->planet_memory);
    galaxy_del (E->G);
    hot_del_player (E->H);

    glDeleteBuffers (1, & E->cell_vbo);
    glDeleteBuffers (1, & E->imposter.vbo);
    glDeleteTextures (1, & E->tex);

    for (unsigned i = 0; i < 3; ++i) {
        glDeleteProgram (E->sh_pl[i].program);
    }

    glDeleteProgram (E->sh_ce.program);

    free (E);
}

