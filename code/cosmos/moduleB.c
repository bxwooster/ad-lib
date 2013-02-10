void
moduleB (
        struct planetB * galaxy,
        struct galaxy_helper * gh,
        unsigned galaxy_size,
        unsigned offset
) {
    for (unsigned i = 0; i < galaxy_size; ++i) {
        gh[i] = galaxy_prepare (galaxy, gh, i);
    }

    unsigned j = planetA_count;
    for (unsigned i = 0; i < galaxy_size; ++i) {
        struct planet_ID pid;
        planet_ID_from_B (
                & pid,
                galaxy,
                gh,
                i,
                & framedata
        );
        planet_memory[offset] = generate_planet_DD (
                & pid,
                & framedata
        );
        offset++;
    }
}

