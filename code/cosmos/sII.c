void
sII (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
{
    struct glts_planeta glts [4];
    struct GLvbo_and_size imposter = {GL_FALSE, 0};
    GLuint tex = GL_FALSE;
    struct planet_DD * planet_memory = NULL;

    unsigned width = 1024; /* fix me. I'm pulled out of thin air. */
    unsigned height = 768;

    char const * glts_names [] = {
        "data/shade/planet.glts",
        "data/shade/planet-normals.glts",
        "data/shade/planet-wireframe.glts",
        "data/shade/test.glts"
    };
    for (unsigned i = 0; i < 4; ++i) {
        glts[i] = load_glts_planeta (gl, glts_names[i]);
        if (glts[i].program == GL_FALSE) goto end;
    }

    tex = get_earth_GLtex (gl, sdl, img);
    if (tex == GL_FALSE) goto end;

    imposter = prepare_GLvbo (gl);
    if (imposter.vbo == GL_FALSE) goto end;

    float fov = get_fov ();
    if (fov == 0.0f) goto end;
    mat4 mproj = standard_projection (width, height, fov);

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

    struct stone_engine E = {
        & mproj,
        width,
        height,
        & imposter,
        galaxy,
        gh,
        galaxy_size,
        planet_memory,
        glts,
        gl,
        sdl,
        & state,
        0.0
    };

    go_go_go(& E);

end:
    free (planet_memory);

    glDeleteBuffers (1, &imposter.vbo);
    glDeleteTextures (1, &tex);

    for (unsigned i = 0; i < 4; ++i) {
        glDeleteProgram (glts[i].program);
    }
}

