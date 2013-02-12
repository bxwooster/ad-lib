void
moduleB (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        E->gh[i] = galaxy_prepare (E->time, E->galaxy, E->gh, i, E->state);
    }

    unsigned offset = E->planetA_count;

    for (unsigned i = 0; i < E->galaxy_size; ++i) {
        struct planet_ID pid;
        planet_ID_from_B (
                E->time,
                & pid,
                E->galaxy,
                E->gh,
                i,
                framedata
        );
        E->planet_memory[offset] = generate_planet_DD (
                & pid,
                framedata
        );
        offset++;
    }
}

