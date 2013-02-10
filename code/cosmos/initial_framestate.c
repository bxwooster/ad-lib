struct framestate
initial_framestate (void) {
    return (struct framestate) {
        camera_initial_B (),
        mat4_identity (),
        {0.0f, 0.0f, 0},
        0,
        0,
        0,
    };
}

