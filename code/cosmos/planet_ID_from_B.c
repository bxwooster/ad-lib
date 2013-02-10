void
planet_ID_from_B (
        struct planet_ID * out,
        struct planetB const * galaxy,
        unsigned planet_number,
        struct frame_DD const * framedata
) {
    (void) framedata;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        assert (planet->where.parent_index == ~0u);

        out->mmodel = mat4_identity ();

        out->size = 1.0f;
    } else {
        out->mmodel = (mat4) {0};

        out->size = 0.0f;
    }

    out->mrot = planet_dayrotation (& planet->day, framedata->time);

    out->colour = planet->colour;
}
