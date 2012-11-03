void
stage_II (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
    GLuint program = GL_FALSE;
    GLuint vbo = GL_FALSE;
    GLuint tex = GL_FALSE;
    struct planethead * planet_list = NULL;

    unsigned width = 1024; /* fix me */
    unsigned height = 768;

    int vertices = 6; // fix me
    float const screen_size = width > height ? width : height;

    do {
    
    program = get_GLprogram (gl);
    if (program == GL_FALSE) break;

    tex = get_earth_GLtex (gl, sdl, img);
    if (tex == GL_FALSE) break;

    vbo = prepare_GLvbo (gl);
    if (vbo == GL_FALSE) break;

    planet_list = planet_list_from_disk ();
    if (planet_list == NULL) break;

    float fov = get_fov ();
    if (fov == 0.0f) break;
    mat4 mproj = standard_projection (width, height, fov);

    struct planet_draw_GLdata GLdata =
           planet_draw_GLdata_from_program (program, gl);

    int error = to_common_draw_state (program, width, height, gl);
    if (error) break;

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

    destroy_planet_list (planet_list);
    glDeleteBuffers (1, &vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (program);
}

