void
advance_framestate (
        struct framestate * state,
        float screen_size,
        struct input const * input
) {
    float nx = input->mouse.x / screen_size;
    float ny = input->mouse.y / screen_size;
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
    state->mouse.lock = input->mouse.buttons;

    vec3 move = {{-dx, dy, 0.0f}};
    state->ori = mat4_moved (& state->ori, & move);

    state->show_normals ^= input->toggle_normals;
    state->show_wireframe ^= input->toggle_wireframe;

    if (input->next_turn) state->turn++;
}

