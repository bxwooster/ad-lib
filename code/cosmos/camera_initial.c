void
camera_initial (struct framestate * S) {
    mat4 one = mat4_identity ();

    vec3 move = {{0.0f, 2.0f, 0.5f}};
    S->mov = mat4_moved (& one, & move);
    
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    S->rot = mat4_rotated_aa (& one, & axis, M_PI * 0.56);
}
