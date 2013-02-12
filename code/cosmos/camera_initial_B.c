mat4
camera_initial_B (void) {
    mat4 mcam = mat4_identity ();

    vec3 move = {{0.0f, 0.0f, -3.0f}};
    mcam = mat4_moved (& mcam, & move);
    
    vec3 axis_z = {{0.0f, 0.0f, 1.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_z, M_PI);

    return mcam;
}
