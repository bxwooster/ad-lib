struct framestate
initial_framestate (void) {
    struct framestate out = {0};
    out.cam = camera_initial ();
    return out;
}

