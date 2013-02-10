void
planet_ID_from_B (
        double time,
        struct planet_ID * out,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct frame_DD const * framedata
) {
    (void) framedata;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        assert (planet->where.parent_index == ~0u);

    } else {

    }

    out->mmodel = gh[planet_number].transform;

    out->mrot = planet_dayrotation (& planet->day, time);

    out->colour = planet->colour;
    
    out->size = gh[planet_number].size;
}
