int
GL_check_errors (
        struct GL * gl
) {
    (void) gl;
    GLuint error = glGetError ();
    if (error != 0) {
        log_info ("There occurred a GL error, # %d.", error);
    }

    return (error != 0);
}

void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

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

    mat4 cam = mat4_multiply (& S->mov, & S->rot);

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-I->mouse.x / q, -I->mouse.y / q, 1.0, 0.0};
    view = vec4_multiply (& cam, & view);

    float ratio  = cam.column.w.element.z / view.element.z;
    float px = view.element.x * ratio + cam.column.w.element.x;
    float py = view.element.y * ratio - cam.column.w.element.y;

    char lock = (I->mouse.buttons & SDL_BUTTON (1)) != 0;

    if (S->lock != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        S->mov.column.w.element.x -= dx;
        S->mov.column.w.element.y += dy;

        if (!lock) S->lock = 0;
    }
    else {
        if (lock) {
            S->lock = 1;
            S->pan.x = px;
            S->pan.y = py;

            log_debug ("%f - %f", px, py);
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
}

void
camera_initial (struct framestate * S) {
    mat4 one = mat4_identity ();

    vec3 move = {{0.0f, 2.0f, 0.5f}};
    S->mov = mat4_moved (& one, & move);
    
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    S->rot = mat4_rotated_aa (& one, & axis, M_PI * 0.56);
}

int closest_planet_DD (void const * a, void const * b) {
    float a_depth = ((struct planet_DD const *) a)->depth;
    float b_depth = ((struct planet_DD const *) b)->depth;

    return (a_depth > b_depth) ? -1 : 1;
}

void
exit_GL (
        struct GL * gl,
        struct SDL * sdl
) {
    (void) sdl;
    if (gl->context != NULL) {
        SDL_GL_DeleteContext (gl->context);
    }
    gl->ready = 0;
}

void
exit_IMG (
        struct IMG * img
) {
    if (img->ready) {
        IMG_Quit ();
        img->ready = 0;
    }
}

void
exit_SDL (
        struct SDL * sdl
) {
    if (sdl->window != NULL) {
        SDL_DestroyWindow (sdl->window);
    }
    if (sdl->ready) {
        SDL_Quit ();
        sdl->ready = 0;
    }
}

struct galaxy_helper
galaxy_prepare (
        double time,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct framestate const * state
) {
    struct galaxy_helper result;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        result.transform = mat4_identity ();
        result.supersize = 1.0f;
    } else {
        unsigned parent = planet->where.parent_index;
        assert (parent < planet_number);

        float rest = 0.0f;
        if (state->turn_transition) {
            float ttd = k_turn_transition_delay;
            rest = (time - state->turn_transition_ends + ttd) / ttd;
        }
        float float_slot = planet->where.orbit_slot + state->turn + rest;

        unsigned orbit_slots = planet->where.orbit_number - 1 + 3;
        float alpha = (2.0f * M_PI * float_slot) / orbit_slots;

        float distance = gh[parent].size * (planet->where.orbit_number + 0.5f);

        vec3 offset = {{0}};
        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        result.transform = mat4_moved (& gh[parent].transform, & offset);
        result.supersize = gh[parent].size * 0.5 * k_planet_size_minifier;
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

struct planet_DD
generate_planet_DD (
    struct planet_ID const * pid,
    struct frame_DD const * framedata
) {
    mat4 mmodel = pid->mmodel;
    mat4 mrot = pid->mrot;

    vec3 first = vec3_diff (
        & mmodel.column.w.v3,
        & framedata->viewi.column.w.v3);

    float p = vec3_length (& first);
    float r = pid->size;
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
        pid->colour
    };

    return data;
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
float
get_fov (void) {
   char * string = load_file ("data/settings/fov");
   if (string == NULL) return 0.0f;

    float fov = atof (string);

    if (fov == 0.0f) {
        log_info ("Can't read FOV.");
    }

    return fov;
}
GLuint
gl_shader_from_source (
        char const * pieces [],
        unsigned count,
        GLenum type
) {
    GLuint shader = GL_FALSE;
    GLint code = GL_FALSE;
    shader = glCreateShader (type);

    unsigned const P = 2;
    unsigned const all_count = P + count;
    size_t memsize = all_count * sizeof (char *);

    char const * all_pieces [all_count];
    memcpy (all_pieces + P, pieces, memsize);
    all_pieces[0] = gl_shader_preamble ();
    all_pieces[1] = (type == GL_VERTEX_SHADER) ?
        "#define VS\n" : "#define FS\n";

    glShaderSource (shader, all_count, all_pieces, NULL);
    glCompileShader (shader);
    glGetShaderiv (shader, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE) {
        log_info("Shader source:\n");
        for (unsigned i = 0; i < all_count; i++)
            log_info ("// piece %d:\n%s", i, all_pieces[i]);
        gl_shader_log (shader);
        glDeleteShader (shader);
        shader = GL_FALSE;
    }

    return shader;
}

void
gl_shader_log (
        GLuint shader
) {
    GLint size = 0;
    glGetShaderiv (shader, GL_INFO_LOG_LENGTH, &size);
    char * log;
    if (size > 0) {
        log = malloc (size);
        if (log) {
            glGetShaderInfoLog (shader, size, NULL, log);
            log_info ("%s", log);
            free (log);
        } else {
            log_info ("No memory to display shader log!");
        }
    } else {
        log_info ("No shader log available.");
    }
}
char const *
gl_shader_preamble (void) {
    int gles = 0;
    #ifdef GLES 
        gles = 1;
    #endif
    return gles ?  
        "#version 100\nprecision mediump float;\n" :
        "#version 120\n";
}

void
go_go_go (
        struct stone_engine * E
) {
    unsigned long frame = 0;
    to_common_draw_GLstate (E);

    for (;;) {
        glDepthMask (GL_TRUE);
        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        #ifndef GLES
            GLenum poly_mode = E->state->show_wireframe ? GL_LINE : GL_FILL;
            glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
        #endif

        //if (GL_check_errors (E->gl)) break;

        E->time = (double) SDL_GetTicks () / 1000;

        struct input physical;
        poll_SDLevents (E, & physical);
        if (physical.halt) break;

        advance_framestate (E, & physical);

        struct frame_DD framedata =
            generate_frame_DD (E->mproj, E->state);

        moduleB (E, & framedata);
        moduleP (E);
        moduleC (E, & framedata);

        SDL_GL_SwapWindow (E->sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

struct GL
init_GL (
        struct SDL const * sdl
) {
    if (SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 2) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 0) != 0)
    {
        log_info ("SDL_GL_SetAttribute error: %s.", SDL_GetError ());
        return (struct GL) {0};
    }

    SDL_GLContext context = SDL_GL_CreateContext (sdl->window);

    if (context == NULL) {
        log_info ("SDL_GL_CreateContext error: %s.", SDL_GetError ());
        return (struct GL) {0};
    }

    #ifdef GLEW
        GLenum glew = glewInit();
        if (glew != GLEW_OK) {
            log_info ("GLEW error: %s.", glewGetErrorString (glew));
            return (struct GL) {0};
        }

        if (!GLEW_VERSION_2_0) {
            log_info ("GL2.0 is not supported.");
            return (struct GL) {0};
        }
    #endif

    return (struct GL) {
        .context = context,
        .ready = 1,
    };
}

struct IMG
init_IMG (void) {
    int require = IMG_INIT_JPG;
    int initted = IMG_Init (require);

    if ((require & initted) != require) {
        log_info ("SDL_image error: %s.", IMG_GetError ());
        return (struct IMG) {0};
    }

    return (struct IMG) {
        .type_jpg = 1,
        .ready = 1,
    };
}

struct SDL
init_SDL (void) {
    if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0) {
        log_info ("SDL_Init error: %s.", SDL_GetError ());
        return (struct SDL) {0};
    }

    unsigned width = 1024;
    unsigned height = 768;
    /* bug: this is the size of the window, not of framebuffer as wanted */

    SDL_Window * window = SDL_CreateWindow ("",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        width, height,
        SDL_WINDOW_OPENGL |
        //SDL_WINDOW_MINIMIZED | /* for debugging */
        //SDL_WINDOW_SHOWN);
        0);

    if (window == NULL) {
        log_info ("SDL_CreateWindow error: %s.", SDL_GetError ());
        return (struct SDL) {0};
    }

    return (struct SDL) {
        .subsystem_video = 1,
        .subsystem_timer = 1,
        .window = window,
        .width = width,
        .height = height,
        .ready = 1,
    };
}

struct framestate
initial_framestate (void) {
    struct framestate out = {0};
    camera_initial (& out);
    out.show_normals = 1;
    out.show_wireframe = 1;
    return out;
}

GLuint // program
link_GLprogram (
        GLuint vs,
        GLuint fs,
        struct GL * gl
) {
    (void) gl;

    GLuint program = glCreateProgram ();
    glAttachShader (program, vs);
    glAttachShader (program, fs);
    glLinkProgram (program);

    GLint code = GL_FALSE;
    glGetProgramiv (program, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        log_info ("Shader linking failed.");
        glDeleteProgram (program);
        return GL_FALSE;
    }

    return program;
}


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
            log_info ("SDL_image error: %s", IMG_GetError ());
            return GL_FALSE;
        }
    }

    Uint32 sdlformat = earth[0]->format->format;

    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB24) return GL_RGB;
    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB888) return GL_BGRA;

    (void) sdl;
    log_info ("Unexpected texture format: %s",
        SDL_GetPixelFormatName (sdlformat)); 
    return GL_FALSE;
}

char * // contents
load_file (
        char const * filename
) {
    long size = -1;

    FILE * fp = fopen (filename, "rb");
    if (fp == NULL) {
        log_info ("Could not open file %s at all.", filename);
        return NULL;
    }

    if (
        fseek (fp, 0L, SEEK_END) != 0 ||
        (size = ftell (fp)) < 0
    ) {
        log_info ("Could not determine how large file %s is exactly.", filename);
        fclose (fp);
        return NULL;
    }

    char * contents = malloc ((size_t) size + 1);

    if (contents == NULL) {
        log_info ("Alas, size %ld proved to be too huge for allocation.", size);
        fclose (fp);
        return NULL;
    }

    if (
        fseek (fp, 0L, SEEK_SET) != 0 ||
        fread(contents, 1, (size_t) size, fp) != (size_t) size
    ) {
        log_info ("Contents of file %s could not even be retrieved.", filename);
        fclose (fp);
        free (contents);
        return NULL;
    }

    contents[size] = '\0';

    return contents;
}
GLuint // program
load_glts (
            struct GL * gl,
            char const * filename,
            char const * typename,
			char const * typecode
) {
    GLuint program = GL_FALSE;
    unsigned maxN = 256;
	char const * sources [maxN]; /* 1k of memory */
	unsigned N = 1; /* first one is used internally */

    /* load initial .glts file */
    const char * at;
    const char * current_file = at = load_file (filename);
	if (current_file == NULL) goto end;

    /* first line must be the following: */
	const char type_string [] = "#pragma type ";
	int count = strlen (type_string);
	if (strncmp (at, type_string, count) != 0) goto end;
	at += count;

    /* check exact type */
	count = strlen (typename);
	if (strncmp (at, typename, count) != 0) goto end;
	at += count;
    char const * base_file = sources[N++] =
        load_glts_file ("mode/glts/", typename, NULL);
    if (base_file == NULL) goto end;

    /* newline */
	if (*at++ != '\n') goto end;

    const char include_str [] = "#pragma include ";
    count = strlen (include_str);

	for (;strncmp (at, include_str, count) == 0;) {
		at += count;
		char const * newline = strchr (at, '\n');
		if (newline == NULL) goto end;

        char const * included_file = sources[N++] =
                      load_glts_file ("data/shade/", at, newline);
        if (included_file == NULL) goto end;

		at = newline + 1;
        if (N >= maxN) {
            log_info ("Whoa there, you included more than %u files!", maxN);
            goto end;
        }
	}

    sources[N++] = current_file;
    sources[0] = (char *) typecode;
    /* will need an extra when typecode is actually used */
    /* note the -1's on two lines below */

    GLuint vs = gl_shader_from_source (sources, N, GL_VERTEX_SHADER);
    GLuint fs = gl_shader_from_source (sources, N, GL_FRAGMENT_SHADER);

    if (vs == GL_FALSE || fs == GL_FALSE)
        log_info ("That happened while loading %s just now.", filename);

    program = link_GLprogram (vs, fs, gl);

    glDeleteShader (vs);
    glDeleteShader (fs);

	at = NULL; /* no syntax errors */

end:
    if (at != NULL)
        log_info ("Syntax error while loading a GLTS: %s:byte-%d",
            filename, (int) (at - current_file));

	for (unsigned n = 1; n < N; ++n) {
        //log_debug ("Source %u: %s", n, sources[n]);
    	free ((char *) sources[n]);
    }

    return program;        
}

struct glts_cello
  load_glts_cello (
            struct GL * gl,
            char const * filename
) {
    struct glts_cello it;

    it.program = load_glts (gl, filename, "cello", "");
    // we could check that program's not GL_FALSE, but we won't.
    
    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        log_info ("GL attribute 'Apos2d' not found");
    }

    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    assert (it.Umvp != -1);

    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Ucenter = glGetUniformLocation (it.program, "Ucenter");
    it.Uradius = glGetUniformLocation (it.program, "Uradius");

    return it;
}
char * // contents
load_glts_file (
        char const * prefix,
        char const * id_starts,
        char const * id_ends_or_null
) {
    char suffix [] = ".glsl";

    size_t id_size = id_ends_or_null ?
        (size_t) (id_ends_or_null - id_starts) :
        strlen (id_starts);
    size_t size = strlen (prefix) + id_size + sizeof (suffix) + 1;

    char included_file [size];
    snprintf (included_file, size, "%s%.*s%s",
        prefix, (int) id_size, id_starts, suffix);

    return load_file (included_file);
}
struct glts_planeta
  load_glts_planeta (
            struct GL * gl,
            char const * filename
) {
    struct glts_planeta it;

    it.program = load_glts (gl, filename, "planeta", "");
    // we could check that program's not GL_FALSE, but we won't.
    //
    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        log_info ("GL attribute 'Apos2d' not found");
    }

    it.Umv = glGetUniformLocation (it.program, "Umv");
    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    assert (it.Umvp != -1);

    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Udepth = glGetUniformLocation (it.program, "Udepth");
    it.Uuvscale = glGetUniformLocation (it.program, "Uuvscale");
    it.Utexture = glGetUniformLocation (it.program, "Uexture");
    // ignore some missing uniforms
    return it;
}
int // exitcode
main (
        int argc,
        char * argv []
)
/* Entry point. Handles the command-line arguments and proceeds. */
{
    (void) argc;
    (void) argv; /* silence the warnings */

    sI ();

    return 0;
}

void
moduleB (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        E->gh[i] = galaxy_prepare (E->time, E->galaxy, E->gh, i, E->state);
    }

    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        struct planet_ID pid;
        planet_ID_from_B (
                E->time,
                & pid,
                E->galaxy,
                E->gh,
                i,
                framedata
        );
        E->planet_memory[i] = generate_planet_DD (
                & pid,
                framedata
        );
    }
}

void moduleC (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    for (unsigned j = 0; j < E->galaxy_size; ++j) {
        struct glts_cello const * shader = E->sh_ce;

        unsigned N = 64;//(unsigned) E->time + 3;
        struct {
            float x;
            float y;
        } tris [N] [6];

        float r1 = E->gh[j].size;
        float r2 = E->gh[j].supersize;
        for (unsigned i = 0; i < N; ++i) {
            float b = i / (float) N * 2 * M_PI;
            float a = (i + 1) / (float) N * 2 * M_PI;
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

        glDepthMask (GL_FALSE);
        glUseProgram (shader->program);
        glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
        glEnableVertexAttribArray (shader->Apos2d);

        vec3 colour = {0.5 * j, 0.4, 0.6};
        glUniform3fv (shader->Ucolour, 1, colour.p);
        glUniform1f (shader->Uradius, r2);
        mat4 mvp = mat4_multiply (& framedata->viewproj, & E->gh[j].transform);
        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, mvp.p);

        glEnable (GL_BLEND);
        glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        glDrawArrays (GL_TRIANGLES, 0, 2 * N * 3);

        colour = (vec3){1.0, 1.0, 1.0};
        glUniform3fv (shader->Ucolour, 1, colour.p);

        glLineWidth (5.0f);
        glDisable (GL_BLEND);
        glDisable (GL_CULL_FACE);

        //glDrawArrays (GL_LINE_LOOP, 0, N*3);
   }
}
void moduleP (
        struct stone_engine * E
) {
    glDisable (GL_BLEND);

    qsort (E->planet_memory, E->galaxy_size, sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (E->state->show_wireframe) {
        choice = 2;
    } else if (E->state->show_normals) {
        choice = 1;
    }

    struct glts_planeta const * shader = E->sh_pl + choice;

    glBindBuffer (GL_ARRAY_BUFFER, E->imposter->vbo);
    E->gl->vertices = E->imposter->size;

    glDepthMask (GL_TRUE);
    glUseProgram (shader->program);
    glVertexAttribPointer (shader->Apos2d, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (shader->Apos2d);

    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        struct planet_DD * data = E->planet_memory + i;

        glUniformMatrix4fv (shader->Umvp, 1, GL_FALSE, data->mvp.p);
        glUniformMatrix4fv (shader->Umv, 1, GL_FALSE, data->mv.p);
        glUniform1f (shader->Udepth, data->depth);
        glUniform1f (shader->Uuvscale, data->uvscale);
        glUniform1i (shader->Utexture, data->texture);
        glUniform3fv (shader->Ucolour, 1, data->colour.p);

        glDrawArrays (GL_TRIANGLES, 0, E->gl->vertices);
    }
}
int // status
parse_galaxy (
        char const * in,
        struct planetB galaxy [],
        unsigned * count
) {
    int read = 0;

    char name [16];
    char where [22];

    struct planetB * a = galaxy;
    unsigned left = *count;
    *count = 0;

    for (;;) {
        /* Is there one more? */
        if (sscanf (in, " it's %15[^: ]%n", name, & read) < 1) break;
        in += read;

        /* Yes. Do we have the memory for it? */
        if (left == 0) {
            log_info ("Exhausted the provided list while parsing a galaxy!");
            return 2;
        }

        /* Go for it */
        memcpy (a->name, name, sizeof (name));
        log_debug ("name = %s", a->name);

        if (sscanf (in, " : { where : %21[^; ]%n", where, & read) < 1)
            goto syntax_error;
        in += read;

        a->where.parent_index = ~0u;
        if (strcmp (where, "center") != 0) {
            if (sscanf (where, "%[^-]-%u-%u%n", name,
                        & a->where.orbit_number,
                        & a->where.orbit_slot, & read) < 3) goto syntax_error;
            if (where[read] != '\0') goto syntax_error;

            for (unsigned i = 0; i < *count; ++i) {
                if (strcmp (name, galaxy[i].name) == 0) {
                    a->where.parent_index = i;
                    break;
                }
            }

            if (a->where.parent_index == ~0u) {
                goto syntax_error;
            }
        }

        if (sscanf (in, " ; orbits : %u%n", & a->orbit_count, & read) < 1)
            goto syntax_error;
        in += read;

        if (sscanf (in, " ; colour : %f, %f, %f%n",
                    a->colour.p,
                    a->colour.p + 1,
                    a->colour.p + 2, & read) < 3) goto syntax_error;
        in += read;

        if (sscanf (in, " ; day: { axis: %f, %f, %f%n",
                a->day.axis.p,
                a->day.axis.p + 1,
                a->day.axis.p + 2, & read) < 3) goto syntax_error;
        in += read;

        if (sscanf (in, " ; period: %f%n", & a->day.period, & read) < 1)
            goto syntax_error;
        in += read;

        sscanf (in, " ; } ; } ;%n", & read);
        in += read;
        
        (*count)++;
        left--;
        a++;
    };

    return 0;

syntax_error:

    log_info ("Galaxy-parsing ended up in a tumult!");
    return 1;
}

void
planet_ID_from_B (
        double time,
        struct planet_ID * out,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct frame_DD const * framedata
) {
    (void) framedata;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        assert (planet->where.parent_index == ~0u);

    } else {

    }

    out->mmodel = gh[planet_number].transform;

    out->mrot = planet_dayrotation (& planet->day, time);

    out->colour = planet->colour;
    
    out->size = gh[planet_number].size;
}
mat4
planet_dayrotation (
        struct planet_day const * day,
        double time
) {
    float theta = (float) ((time / day->period) * M_PI * 2.0);

    mat4 out = mat4_identity ();
    out.column.w.v3 = (vec3) {{0}};
    return mat4_rotated_aa (& out, & day->axis, theta);
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

void
sI (void)
/* ... where libraries are initalized and put to good use. */
{
    log_info ("Revving up.");

    struct SDL sdl = {0};
    struct IMG img = {0};
    struct GL  gl  = {0};

    /*
     * GL, SDL, IMG correspond to the state of respective external libraries.
     * Pass them as a pointer to (mutable!) struct, whenever a library is used.
     */

    do {
        img = init_IMG ();
        if (!img.ready) break;

        sdl = init_SDL ();
        if (!sdl.ready) break;

        gl = init_GL (& sdl);
        if (!gl.ready) break;
        
        /* All systems go! */
        sII (& gl, & sdl, & img);

    } while (0); /* break out */

    exit_GL (& gl, & sdl);
    exit_SDL (& sdl);
    exit_IMG (& img);
}

void
sII (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
{
    struct glts_planeta sh_pl [3];
    struct glts_cello sh_ce;
    struct GLvbo_and_size imposter = {GL_FALSE, 0};
    GLuint cell_vbo = GL_FALSE;
    GLuint tex = GL_FALSE;
    struct planet_DD * planet_memory = NULL;

    char const * glts_names [] = {
        "data/shade/planet.glts",
        "data/shade/planet-normals.glts",
        "data/shade/planet-wireframe.glts",
    };
    for (unsigned i = 0; i < 3; ++i) {
        sh_pl[i] = load_glts_planeta (gl, glts_names[i]);
        if (sh_pl[i].program == GL_FALSE) goto end;
    }

    sh_ce = load_glts_cello (gl, "data/shade/test.glts");
    if (sh_ce.program == GL_FALSE) goto end;

    tex = get_earth_GLtex (gl, sdl, img);
    if (tex == GL_FALSE) goto end;

    imposter = prepare_imposter (gl);
    if (imposter.vbo == GL_FALSE) goto end;

    glGenBuffers (1, & cell_vbo);
    if (cell_vbo == GL_FALSE) goto end; // log?

    float fov = get_fov ();
    if (fov == 0.0f) goto end;
    mat4 mproj = standard_projection (sdl->width, sdl->height, fov);

    char * galaxytext = load_file ("data/galaxy");
    if (galaxytext== NULL) goto end;

    struct planetB galaxy [16];
    struct galaxy_helper gh [16];
    unsigned galaxy_size = 16;
    parse_galaxy (galaxytext, galaxy, &galaxy_size);
    log_debug ("Galaxy is %u large", galaxy_size);

    free (galaxytext);

    planet_memory =
        malloc (galaxy_size * sizeof (struct planet_DD));

    struct framestate state = initial_framestate ();

    struct stone_engine E = {0};

    E.mproj = & mproj;
    E.imposter = & imposter;
    E.cell_vbo = cell_vbo;
    E.galaxy = galaxy;
    E.gh = gh;
    E.galaxy_size = galaxy_size;
    E.planet_memory = planet_memory;
    E.sh_pl = sh_pl;
    E.sh_ce = & sh_ce;
    E.gl = gl;
    E.sdl = sdl;
    E.state = & state;
    E.time = 0.0;

    go_go_go(& E);

end:
    free (planet_memory);

    glDeleteBuffers (1, & cell_vbo);
    glDeleteBuffers (1, & imposter.vbo);
    glDeleteTextures (1, & tex);

    for (unsigned i = 0; i < 3; ++i) {
        glDeleteProgram (sh_pl[i].program);
    }
    glDeleteProgram (sh_ce.program);
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
to_common_draw_GLstate (
        struct stone_engine * E
) {
    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, E->sdl->width, E->sdl->height);
}
