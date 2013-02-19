struct framestate
initial_framestate (void) {
    struct framestate out = {0};
    camera_initial (& out);
    return out;
}

