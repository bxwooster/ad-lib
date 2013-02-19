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

