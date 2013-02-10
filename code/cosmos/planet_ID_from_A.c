void
planet_ID_from_A (
        struct planet_ID * out,
        struct planetA const * planet,
        struct frame_DD const * framedata
) {
    float phi = (float) ((framedata->time / planet->year.period) * pi () * 2.0);

    out->mmodel = mat4_identity ();
    out->mmodel.column.w.element.x += planet->year.major * cosf (phi);
    out->mmodel.column.w.element.y += planet->year.minor * sinf (phi);

    float theta = (float) ((framedata->time / planet->day.period) * pi () * 2.0);

    out->mrot = mat4_identity ();
    out->mrot.column.w.v3 = (vec3) {{0}};
    out->mrot = mat4_rotated_aa (& out->mrot, & planet->day.axis, theta);

    out->size = planet->size;

    out->colour = planet->colour;
}
