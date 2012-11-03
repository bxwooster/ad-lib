mat4
camera_initial (void) {
    mat4 mcam = mat4_identity ();

    vec3 axis_x = {{1.0f, 0.0f, 0.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_x, pi () / 2.4f);

    vec3 move = {{0.0f, 0.0f, -13.0f}};
    mcam = mat4_moved (& mcam, & move);
    
    vec3 axis_z = {{0.0f, 0.0f, 1.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_z, pi ());

    return mcam;
}
