void
stage_II (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
    GLuint vs = GL_FALSE;
    GLuint fs = GL_FALSE;
    GLuint prog = GL_FALSE;
    GLuint vbo = GL_FALSE;
    GLuint tex = GL_FALSE;

    struct planethead * planet_list = NULL;

    unsigned width = 1024; /* needs correcting */
    unsigned height = 768;

    do {

    char * kilobyte = malloc (1024);
    if (!kilobyte) {
        log_info ("Unacceptably low on memory!");
        break;
    }

    if (load_file ("data/settings/fov", kilobyte, 1024) != 0) break;

    float fov = atof (kilobyte);
    fov = 60.0f; /* fix me */

    if (fov == 0.0f) {
        log_info ("Can't read FOV.");
        break;
    }
    
    if (load_file ("data/shade/planet.vert", kilobyte, 1024) != 0) break;

    vs = gl_shader_from_source (kilobyte, GL_VERTEX_SHADER);
    if (vs == GL_FALSE) break;

    if (load_file ("data/shade/planet.frag", kilobyte, 1024) != 0) break;

    fs = gl_shader_from_source (kilobyte, GL_FRAGMENT_SHADER);
    if (vs == GL_FALSE) break;

    prog = link_GLprogram (vs, fs, gl);
    if (prog == GL_FALSE) break;

    glUseProgram (prog);

    SDL_Surface * earth [6] = {0};
    GLenum GLformat = load_earth (earth, img, sdl);
    if (GLformat == GL_FALSE) break;

    tex = prepare_GLtex (earth, GLformat, gl);

    for (int i = 0; i < 6; i++) {
        SDL_FreeSurface (earth[i]);
    }

    glActiveTexture (GL_TEXTURE0);
    glEnable (GL_DEPTH_TEST);
    glViewport (0, 0, width, height);

    int vertices = 6; // fix me
    vbo = prepare_GLvbo (gl);

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

    planet_list = planet_list_from_disk ();
    if (planet_list == NULL) break;

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

    if (planet_list != NULL) {
        destroy_planet_list (planet_list);
    }

    glDeleteBuffers (1, &vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (prog);
}

