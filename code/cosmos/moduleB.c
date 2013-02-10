void
moduleB (
        double time,
        struct framestate const * state,
        struct planetB * galaxy,
        struct galaxy_helper * gh,
        unsigned galaxy_size,
        struct frame_DD const * framedata,
        struct planet_DD * planet_memory,
        unsigned offset
) {
    for (unsigned i = 0; i < galaxy_size; ++i) {
        gh[i] = galaxy_prepare (time, galaxy, gh, i, state);
    }

    for (unsigned i = 0; i < galaxy_size; ++i) {
        struct planet_ID pid;
        planet_ID_from_B (
                time,
                & pid,
                galaxy,
                gh,
                i,
                framedata
        );
        planet_memory[offset] = generate_planet_DD (
                & pid,
                framedata
        );
        offset++;
    }
}

