void
sII (
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
    struct planetlistA_head * planet_list = NULL;
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

        unsigned planetA_count = planet_list_from_disk (
             "data/spawn-none",
             & planet_list
        );

        float fov = get_fov ();
        if (fov == 0.0f) break;
        mat4 mproj = standard_projection (width, height, fov);

        char * galaxytext = load_file ("data/galaxy");
        if (galaxytext== NULL) break;

        struct planetB galaxy [16];
        struct galaxy_helper gh [16];
        unsigned planetB_count = 16;
        parse_galaxy (galaxytext, galaxy, &planetB_count);
        log_debug ("Galaxy is %u large", planetB_count);

        free (galaxytext);

        planet_memory =
            malloc ((planetA_count + planetB_count) * sizeof (struct planet_DD));

        sIII (
                & mproj,
                width, height,
                screen_size,
                & imposter,
                planet_list,
                planetA_count,
                galaxy,
                gh,
                planetB_count,
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

