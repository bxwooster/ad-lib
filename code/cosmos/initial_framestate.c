struct framestate
initial_framestate (void) {
    struct framestate out = {0};
    camera_initial (& out);
    out.show_normals = 1;
    return out;
}

