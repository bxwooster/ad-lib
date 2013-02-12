void moduleP (
        struct stone_engine * E
) {
    qsort (E->planet_memory, E->galaxy_size, sizeof (struct planet_DD), closest_planet_DD);

    unsigned choice = 0;
    if (E->state->show_wireframe) {
        choice = 2;
    } else if (E->state->show_normals) {
        choice = 1;
    }

    to_planeta_GLstate (E->gl, E->imposter, E->glts + choice);

    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        planet_draw (E->planet_memory + i, E->glts + choice, E->gl);
    }
}
