void
planet_ID_from_B (
        struct planet_ID * out,
        struct planetB const * planet,
        struct frame_DD const * framedata
) {
    (void) framedata;

    out->mmodel = mat4_identity ();
    out->mrot = mat4_identity ();
    out->size = 1.0f;
    out->colour = planet->colour;
}
