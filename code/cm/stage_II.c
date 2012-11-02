void
stage_II (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
    (void) img;

    GLuint prog = GL_FALSE;
    GLuint vs = GL_FALSE;
    GLuint fs = GL_FALSE;
    GLuint vbo = GL_FALSE;
    GLuint tex = GL_FALSE;

    unsigned width = 1024; /* needs correcting */
    unsigned height = 768;

    do {

    char * kilobyte = malloc (1024);
    if (!kilobyte) {
        log_info ("Unacceptably low on memory!");
        break;
    }

    if (load_file ("data/settings/fov", kilobyte, 1024) != 0) {
        break;
    }

    float fov = atof (kilobyte);
    fov = 60.0f; //hack

    if (fov == 0.0f) {
        log_info ("Can't read FOV.");
        break;
    }
    
    if (load_file ("data/shade/planet.vert", kilobyte, 1024) != 0) {
        break;
    }

    vs = gl_shader_from_source (kilobyte, GL_VERTEX_SHADER);
    if (vs == GL_FALSE) {
        break;
    }

    if (load_file ("data/shade/planet.frag", kilobyte, 1024) != 0) {
        break;
    }

    fs = gl_shader_from_source (kilobyte, GL_FRAGMENT_SHADER);
    if (vs == GL_FALSE) {
        break;
    }

    prog = glCreateProgram ();

    glAttachShader (prog, vs);
    glAttachShader (prog, fs);

    glLinkProgram (prog);

    GLint code = GL_FALSE;
    glGetProgramiv (prog, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        log_info ("Shader linking failed.");
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
        log_info ("GL attribute 'pos' not found");
        break;
    }

    glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray (attribute_pos);

    float const screen_aspect = ((float) width) / height;
    float const screen_size = width > height ? width : height;
    mat4 mproj = projection_from_afn (screen_aspect, fov, 0.0f);

    struct planet_draw_GLdata GLdata =
           planet_draw_GLdata_from_program (prog, gl);

    struct planethead * planet_list = planet_list_from_disk ();
    if( planet_list == NULL ) {
        log_info ("Could not load the planets.");
        break;
    }

    stage_III (
            & mproj,
            screen_size,
            vertices,
            planet_list,
            & GLdata,
            gl,
            sdl
    );

    } while (0); /* ... */

    glDeleteBuffers (1, &vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (prog);
}

