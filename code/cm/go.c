void
go (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
    (void) gl;
    (void) img;

    int error = 0;

    GLuint prog = GL_FALSE;
    GLuint vs = GL_FALSE;
    GLuint fs = GL_FALSE;
    GLuint vbo = GL_FALSE;
    GLuint tex = GL_FALSE;

    unsigned width = 1024; /* needs correcting */
    unsigned height = 768;

    DIR * sysdir = NULL;

    TAILQ_HEAD (head, sysplanet) list;
    TAILQ_INIT (&list);

    do { /* ... */

    struct settings settings;
    if (loadsettings (&settings, "data/settings") != 0) {
        log_info ("No settings file found.");
        break;
    }

    vs = loadshader ("data/shade/planet.vert", GL_VERTEX_SHADER);
    if (vs == GL_FALSE) {
        error = __LINE__;
        break;
    }

    fs = loadshader ("data/shade/planet.frag", GL_FRAGMENT_SHADER);
    if (fs == GL_FALSE) {
        error = __LINE__;
        break;
    }

    prog = glCreateProgram ();

    glAttachShader (prog, vs);
    glAttachShader (prog, fs);

    glLinkProgram (prog);

    GLint code = GL_FALSE;
    glGetProgramiv (prog, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        error = __LINE__;
        break;
    }

    glUseProgram (prog);

    struct {
        float x;
        float y;
    } const tris [] = {
        {-1.0,-1.0},
        { 1.0,-1.0},
        {-1.0, 1.0},
        {-1.0, 1.0},
        { 1.0,-1.0},
        { 1.0, 1.0}
    };
    int const vertices = sizeof (tris) / sizeof (tris[0]);

    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    char const * const earthimg [6] = {
        "art/earth/posx.jpg",
        "art/earth/negx.jpg",
        "art/earth/posy.jpg",
        "art/earth/negy.jpg",
        "art/earth/posz.jpg",
        "art/earth/negz.jpg",
    };

    SDL_Surface * earth [6];
    for (int i = 0; i < 6; ++i) {
        earth[i] = IMG_Load (earthimg[i]);
        if (earth[i] == NULL) {
            log_info ("SDL_image error: %s", IMG_GetError ());
            error = __LINE__;
            break;
        }
    }

    Uint32 sdlformat = earth[0]->format->format;
    GLenum glformat = GL_FALSE;
    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB24) {
        glformat = GL_RGB;
    } else if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB888) {
        glformat = GL_BGRA;
    } else {
        log_info ("Unexpected texture format: %s",
            SDL_GetPixelFormatName (sdlformat)); 
        error = __LINE__;
        break;
    }

    glGenTextures (1, &tex);
    glBindTexture (GL_TEXTURE_CUBE_MAP, tex);

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

    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_TEXTURE_MIN_FILTER,
        GL_NEAREST_MIPMAP_LINEAR);

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
            0, glformat, GL_UNSIGNED_BYTE, earth[i]->pixels);
    }

    for (int i = 0; i < 6; i++) {
        SDL_FreeSurface (earth[i]);
    }

    glActiveTexture (GL_TEXTURE0);

    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, width, height);

    GLuint const attribute_pos = (GLuint) glGetAttribLocation (prog, "pos");
    if (attribute_pos == (GLuint) -1) {
        error = __LINE__;
        break;
    }

    glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attribute_pos);

    GLint const uniform_depth = glGetUniformLocation (prog, "depth");
    if (uniform_depth == -1) {
        log_info ("GL uniform 'depth' not found");
    }

    GLint const uniform_mvp = glGetUniformLocation (prog, "mvp");
    if (uniform_mvp == -1) {
        log_info ("GL uniform 'mvp' not found");
    }

    GLint const uniform_mv = glGetUniformLocation (prog, "mv");
    if (uniform_mv == -1) {
        log_info ("GL uniform 'mv' not found");
    }

    GLint const uniform_color = glGetUniformLocation (prog, "color");
    if (uniform_color == -1) {
        log_info ("GL uniform 'color' not found");
    }

    GLint const uniform_uvscale = glGetUniformLocation (prog, "uvscale");
    if (uniform_uvscale == -1) {
        log_info ("GL uniform 'uvscale' not found");
    }

    GLint const uniform_texture = glGetUniformLocation (prog, "texture");
    if (uniform_texture == -1) {
        log_info ("GL uniform 'texture' not found");
    }

    mat4 mori = mat4_identity ();

    mat4 mcam = mat4_identity ();
    vec3 axis_x = {{1.0f, 0.0f, 0.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_x, pi () / 2.4f);
    vec3 move = {{0.0f, 0.0f, -13.0f}};
    mcam = mat4_moved (& mcam, & move);
    vec3 axis_z = {{0.0f, 0.0f, 1.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_z, pi ());

    char const * const dirname = "data/spawn";
    sysdir = opendir (dirname);
    if (sysdir == NULL) {
        error = __LINE__;
        break;
    }

    struct dirent * dirent = NULL;
    while ((dirent = readdir (sysdir)) != NULL) {
        if (dirent->d_name[0] != '.') {
            size_t len = strlen (dirname) + 1 + strlen (dirent->d_name) + 1;
            struct sysplanet * item = malloc (sizeof (*item));
            assert (item != NULL);
            item->file = (char *) malloc (len);
            assert (item->file != NULL);
            
            snprintf (item->file, len, "%s/%s", dirname, dirent->d_name);
            TAILQ_INSERT_TAIL (&list, item, _);

            if (loadplanet (&item->planet, item->file) != 0) {
                error = __LINE__;
                break;
            }
        }
    }

    float x = 0;
    float y = 0;
    int mouselock = 0;
    for (;;) {
        GLuint glerror = glGetError ();
        if (glerror != 0) {
            log_info ("GL error # %d.", glerror);
            error = __LINE__;
            break;
        }

        SDL_Event evt;
        if (SDL_PollEvent (&evt)) {
            if (evt.type == SDL_KEYDOWN) {
                SDL_Keycode key = evt.key.keysym.sym;
                if (key == SDLK_ESCAPE) {
                    break;
                }
            } else if (evt.type == SDL_QUIT) {
                break;
            }
        }

        int ix, iy;
        Uint8 mousebuttons = SDL_GetMouseState(&ix, &iy);

        float norm = width > height ? width : height;
        float nx = ix / norm;
        float ny = iy / norm;
        float dx;
        float dy;
        if (mouselock != 0) {
            dx = x - nx;
            dy = y - ny;
        } else {
            dx = 0;
            dy = 0;
        }
        x = nx;
        y = ny;

        mouselock = mousebuttons;

        float const ROTATION_SPEED = 4.0f;
        float angle = sqrtf (dx * dx + dy * dy) * ROTATION_SPEED;
        vec3 axis = {{dy, 0.0f, dx}};

        if (angle != 0.0f) mori = mat4_rotated_aa (& mori, & axis, angle);

        double time = (double) SDL_GetTicks () / 1000;

        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        mat4 mviewi = mat4_multiply (& mori, & mcam);
        mat4 mview = mat4_inverted_rtonly (& mviewi);

        struct sysplanet * item;
        TAILQ_FOREACH(item, &list, _) {
            float tosurface;
            float apparentratio;
            mat4 mrot;
            mat4 mmodel;

            {
                struct planet const * planet = &item->planet;

                float phi = (float)
                    ((time / planet->orbit.period) * pi () * 2.0);

                mmodel = planet->orbit.matrix;
                mmodel.column.w.element.x +=
                    planet->orbit.major * cosf (phi);
                mmodel.column.w.element.y +=
                    planet->orbit.minor * sinf (phi);

                vec3 first = vec3_diff (
                    & mmodel.column.w.v3,
                    & mviewi.column.w.v3);

                float p = vec3_length (& first);
                float r = planet->size;
                float apparent = sqrtf (p * p - r * r) * r / p;
                float offset = (r * r) / p;

                vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
                vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

                vec3 second;

                if (first.element.x < first.element.y) {
                    second = vec3_product (& first, & unit_x);
                } else {
                    second = vec3_product (& first, & unit_y);
                }

                vec3 third = vec3_product (& first, & second);

                first = vec3_normalized (& first);
                second = vec3_normalized (& second);
                third = vec3_normalized (& third);

                mat4 rotation = {{0}};
                rotation.column.z.v3 = first;
                rotation.column.x.v3 = second;
                rotation.column.y.v3 = third;
                rotation.p[15] = 1.0f;
                mmodel = mat4_multiply (& mmodel, & rotation);

                mrot = mmodel;
                mrot.p[12] = mrot.p[13] = mrot.p[14] = 0.0f;

                vec3 move = {{0.0f, 0.0f, -offset}};
                mmodel = mat4_moved (& mmodel, & move);
                mmodel = mat4_scaled (& mmodel, apparent);

                tosurface = p - r;
                apparentratio = apparent / r;
            }

            float const aspect = ((float) width) / height;
            mat4 matrix = projection_from_afn (aspect, settings.fov, 0.0f);
            matrix = mat4_multiply (& matrix, & mview);
            matrix = mat4_multiply (& matrix, & mmodel);
            glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix.p);

            glUniformMatrix4fv (uniform_mv, 1, GL_FALSE, mrot.p);

            float const hack = logf (tosurface) / 1000.0f;
            glUniform1f (uniform_depth, hack);

            glUniform1f (uniform_uvscale, apparentratio);
            glUniform3fv (uniform_color, 1, item->planet.color);

            glUniform1i (uniform_texture, 0);

            glDrawArrays (GL_TRIANGLES, 0, vertices);
        }
 
        /* return value? */ SDL_GL_SwapWindow (sdl->window);
    }

    } while (0); /* ... */

    {
        struct sysplanet * item;
        struct sysplanet * tvar;

        TAILQ_FOREACH_SAFE(item, &list, _, tvar) {
            free ((void *) item->file);
            TAILQ_REMOVE (&list, item, _);
            free ((void *) item);
        }
    }

    if (sysdir != NULL) {
        closedir (sysdir);
    }

    glDeleteBuffers (1, &vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (prog);

    if (error) {
        log_info ("Error # %d.", error);
    }
}

