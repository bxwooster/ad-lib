void
stage_II (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
/* ... where the run-time constants are introduced */
{
    GLuint program = GL_FALSE;
    GLuint vbo = GL_FALSE;
    GLuint tex = GL_FALSE;
    struct planethead * planet_list = NULL;
    struct planet_DD * planet_memory = NULL;

    unsigned width = 1024; /* fix me. I'm pulled out of thin air. */
    unsigned height = 768;

    int vertices = 6; // fix me. I'm related to vbo.
    float screen_size = width > height ? width : height;

    do {
        program = get_GLprogram (gl);
        if (program == GL_FALSE) break;

        tex = get_earth_GLtex (gl, sdl, img);
        if (tex == GL_FALSE) break;

        vbo = prepare_GLvbo (gl);
        if (vbo == GL_FALSE) break;

        unsigned planet_count = planet_list_from_disk (& planet_list);
        if (planet_count == 0) break;

        struct planet_DD * planet_memory =
            malloc (planet_count * sizeof (struct planet_DD));

        float fov = get_fov ();
        if (fov == 0.0f) break;
        mat4 mproj = standard_projection (width, height, fov);

        struct planet_GD GLdata =
               planet_GD_from_shader (program, gl);

        stage_III (
                & mproj,
                width, height,
                screen_size,
                vertices,
                planet_list,
                planet_memory,
                & GLdata,
                program,
                gl,
                sdl
        );
    } while (0); /* break out */

    destroy_planet_list (planet_list);
    free (planet_memory);
    glDeleteBuffers (1, &vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (program);
}

