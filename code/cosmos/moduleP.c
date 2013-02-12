void moduleP (
        struct stone_engine * E
) {
    unsigned total = E->planetA_count + E->galaxy_size;
    qsort (E->planet_memory, total, sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (E->state->show_wireframe) {
        choice = 2;
    } else if (E->state->show_normals) {
        choice = 1;
    }

    to_planeta_GLstate (E->gl, E->imposter, E->glts + choice);

    for (unsigned i = 0; i < total; ++i) {
        planet_draw (E->planet_memory + i, E->glts + choice, E->gl);
    }
}
