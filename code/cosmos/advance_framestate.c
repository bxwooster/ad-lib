void
advance_framestate (
        struct stone_engine * E,
        struct input const * input
) {
    float nx = input->mouse.x / E->screen_size;
    float ny = input->mouse.y / E->screen_size;
    float dx;
    float dy;

    struct framestate * S = E->state;

    if (S->mouse.lock != 0) {
        dx = S->mouse.x - nx;
        dy = S->mouse.y - ny;
    } else {
        dx = 0;
        dy = 0;
    }
    S->mouse.x = nx;
    S->mouse.y = ny;
    S->mouse.lock = input->mouse.buttons;

    vec3 move = {{-dx, dy, 0.0f}};
    S->ori = mat4_moved (& S->ori, & move);

    S->show_normals ^= input->toggle_normals;
    S->show_wireframe ^= input->toggle_wireframe;

    if (input->next_turn && !S->turn_transition) {
        S->turn_transition = 1;
        S->turn_transition_ends = E->time + TURN_TRANSITION_DELAY;
    }

    if (S->turn_transition && E->time > S->turn_transition_ends) {
        S->turn++;
        S->turn_transition = 0;
    }
}

