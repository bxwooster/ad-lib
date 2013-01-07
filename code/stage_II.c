void
stage_II (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
/* ... where the run-time constants are introduced */
{
    struct cosmosA_glts glts [3] = {
        {{0}, GL_FALSE},
        {{0}, GL_FALSE},
        {{0}, GL_FALSE},
    };
    struct GLvbo_and_size imposter = {GL_FALSE, 0};
    GLuint tex = GL_FALSE;
    struct planethead * planet_list = NULL;
    struct planet_DD * planet_memory = NULL;

    unsigned width = 1024; /* fix me. I'm pulled out of thin air. */
    unsigned height = 768;

    float screen_size = width > height ? width : height;

    do {
        glts[0] = load_cosmosA_glts (gl, "data/tsh/planet.glts");
        if (glts[0].program == GL_FALSE) break;

        glts[1] = load_cosmosA_glts (gl, "data/tsh/planet-normals.glts");
        if (glts[1].program == GL_FALSE) break;

        glts[2] = load_cosmosA_glts (gl, "data/tsh/planet-wireframe.glts");
        if (glts[2].program == GL_FALSE) break;

        tex = get_earth_GLtex (gl, sdl, img);
        if (tex == GL_FALSE) break;

        imposter = prepare_GLvbo (gl);
        if (imposter.vbo == GL_FALSE) break;

        unsigned planet_count = planet_list_from_disk (& planet_list);
        if (planet_count == 0) break;

        struct planet_DD * planet_memory =
            malloc (planet_count * sizeof (struct planet_DD));

        float fov = get_fov ();
        if (fov == 0.0f) break;
        mat4 mproj = standard_projection (width, height, fov);

        stage_III (
                & mproj,
                width, height,
                screen_size,
                & imposter,
                planet_list,
                planet_memory,
                glts,
                gl,
                sdl
        );
    } while (0); /* break out */

    destroy_planet_list (planet_list);
    free (planet_memory);
    glDeleteBuffers (1, &imposter.vbo);
    glDeleteTextures (1, &tex);
    glDeleteProgram (glts[0].program);
    glDeleteProgram (glts[1].program);
    glDeleteProgram (glts[2].program);
}

