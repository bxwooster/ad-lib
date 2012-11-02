void advance_framestate (
        struct framestate * state,
        float screen_size,
        int ix, int iy,
        uint8_t mousebuttons
) {
    float nx = ix / screen_size;
    float ny = iy / screen_size;
    float dx;
    float dy;

    if (state->mouse.lock != 0) {
        dx = state->mouse.x - nx;
        dy = state->mouse.y - ny;
    } else {
        dx = 0;
        dy = 0;
    }
    state->mouse.x = nx;
    state->mouse.y = ny;
    state->mouse.lock = mousebuttons;

    float const ROTATION_SPEED = 4.0f;
    float angle = sqrtf (dx * dx + dy * dy) * ROTATION_SPEED;
    vec3 axis = {{dy, 0.0f, dx}};

    if (angle != 0.0f) {
        state->ori = mat4_rotated_aa (& state->ori, & axis, angle);
    }
}

