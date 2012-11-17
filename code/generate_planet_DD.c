struct planet_DD
generate_planet_DD (
    double time,
    struct planet const * planet,
    struct frame_DD const * framedata
) {
    float phi = (float) ((time / planet->year.period) * pi () * 2.0);

    mat4 mmodel = mat4_identity ();

    mmodel.column.w.element.x += planet->year.major * cosf (phi);
    mmodel.column.w.element.y += planet->year.minor * sinf (phi);

    vec3 first = vec3_diff (
        & mmodel.column.w.v3,
        & framedata->viewi.column.w.v3);

    float p = vec3_length (& first);
    float r = planet->size;
    float apparent = sqrtf (p * p - r * r) * r / p;
    float apparentratio = apparent / r;
    float offset = (r * r) / p;
    float tosurface = p - r;
    float hack = logf (tosurface) / 1000.0f;

    vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
    vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

    vec3 second = first.element.x < first.element.y ?
        vec3_product (& first, & unit_x) :
        vec3_product (& first, & unit_y) ;

    vec3 third = vec3_product (& first, & second);

    mat4 rotation = {.p[15] = 1.0f};
    rotation.column.z.v3 = vec3_normalized (& first);
    rotation.column.x.v3 = vec3_normalized (& second);
    rotation.column.y.v3 = vec3_normalized (& third);
    mmodel = mat4_multiply (& mmodel, & rotation);

    mat4 rot = mat4_identity ();
    rot.column.w.v3 = (vec3) {{0}};
    float theta = (float) ((time / planet->day.period) * pi () * 2.0);
    rot = mat4_rotated_aa (& rot, & planet->day.axis, theta);
    rot = mat4_multiply (& rot, & mmodel);

    vec3 move = {{0.0f, 0.0f, -offset}};
    mmodel = mat4_moved (& mmodel, & move);
    mmodel = mat4_scaled (& mmodel, apparent);

    mat4 mvp = mat4_multiply (& framedata->viewproj, & mmodel);

    struct planet_DD data = {
        mvp,
        rot,
        hack,
        apparentratio,
        0, /* ? */
        planet->colour
    };

    return data;
}
