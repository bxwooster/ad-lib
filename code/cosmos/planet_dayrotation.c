mat4
planet_dayrotation (
        struct planet_day const * day,
        double time
) {
    float theta = (float) ((time / day->period) * pi () * 2.0);

    mat4 out = mat4_identity ();
    out.column.w.v3 = (vec3) {{0}};
    return mat4_rotated_aa (& out, & day->axis, theta);
}
        
