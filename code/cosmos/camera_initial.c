mat4
camera_initial (void) {
    mat4 mcam = mat4_identity ();

    vec3 move = {{0.0f, 2.0f, 1.0f}};
    mcam = mat4_moved (& mcam, & move);
    
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis, M_PI * 0.66);

    return mcam;
}
