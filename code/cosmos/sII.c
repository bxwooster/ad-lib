void
sII (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
/* ... where the run-time constants are introduced */
{
    struct glts_planeta glts [3];
    struct GLvbo_and_size imposter = {GL_FALSE, 0};
    GLuint tex = GL_FALSE;
    struct planetlistA_head * planet_list = NULL;
    struct planet_DD * planet_memory = NULL;

    unsigned width = 1024; /* fix me. I'm pulled out of thin air. */
    unsigned height = 768;

    float screen_size = width > height ? width : height;

    char const * glts_names [] = {
        "data/shade/planet.glts",
        "data/shade/planet-normals.glts",
        "data/shade/planet-wireframe.glts"
    };
    for (unsigned i = 0; i < 3; ++i) {
        glts[i] = load_glts_planeta (gl, glts_names[i]);
        if (glts[i].program == GL_FALSE) goto end;
    }

    tex = get_earth_GLtex (gl, sdl, img);
    if (tex == GL_FALSE) goto end;

    imposter = prepare_GLvbo (gl);
    if (imposter.vbo == GL_FALSE) goto end;

    unsigned planetA_count = planet_list_from_disk (
         "data/spawn-none",
         & planet_list
    );

    float fov = get_fov ();
    if (fov == 0.0f) goto end;
    mat4 mproj = standard_projection (width, height, fov);

    char * galaxytext = load_file ("data/galaxy");
    if (galaxytext== NULL) goto end;

    struct planetB galaxy [16];
    struct galaxy_helper gh [16];
    unsigned planetB_count = 16;
    parse_galaxy (galaxytext, galaxy, &planetB_count);
    log_debug ("Galaxy is %u large", planetB_count);

    free (galaxytext);

    planet_memory =
        malloc ((planetA_count + planetB_count) * sizeof (struct planet_DD));

    struct stone_engine E = {
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
    };

    sIII(& E);


end:
    destroy_planet_list (planet_list);
    free (planet_memory);

    glDeleteBuffers (1, &imposter.vbo);
    glDeleteTextures (1, &tex);

    for (unsigned i = 0; i < 3; ++i) {
        glDeleteProgram (glts[i].program);
    }
}

