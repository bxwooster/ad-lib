void moduleP (
    struct framestate const * state,
    struct planet_DD * planet_memory,
    unsigned total,
    struct GL * gl,
    struct GLvbo_and_size * imposter,
    struct glts_planeta const glts [3]
) {
    qsort (planet_memory, total, sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (state->show_wireframe) {
        choice = 2;
    } else if (state->show_normals) {
        choice = 1;
    }

    to_planeta_GLstate (gl, imposter, glts + choice);

    for (unsigned i = 0; i < total; ++i) {
        planet_draw (planet_memory + i, glts + choice, gl);
    }
}
