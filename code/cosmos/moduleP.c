void moduleP (
    struct framestate const * state,
    struct planet_DD * planet_memory,
    unsigned total,
    struct GL * gl,
    struct cosmosA_glts const glts [3]
) {
    qsort (planet_memory, total, sizeof (struct planet_DD), closest_planet_DD);

    struct cosmosA_layout const * layout = to_planet_GLstate (
            state,
            gl,
            glts
    );

    for (unsigned i = 0; i < total; ++i) {
        planet_draw (planet_memory + i, layout, gl);
    }

}
