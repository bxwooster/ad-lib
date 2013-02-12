void
planet_ID_from_A (
        double time,
        struct planet_ID * out,
        struct planetA const * planet
) {
    float phi = (float) ((time / planet->year.period) * M_PI * 2.0);

    out->mmodel = mat4_identity ();
    out->mmodel.column.w.element.x += planet->year.major * cosf (phi);
    out->mmodel.column.w.element.y += planet->year.minor * sinf (phi);

    out->mrot = planet_dayrotation (& planet->day, time);

    out->size = planet->size;

    out->colour = planet->colour;
}
