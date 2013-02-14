void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

    float k = S->cam.column.w.element.z * tanf (M_PI / 180 / 2 * 60.0);
    float px = I->mouse.x * k;
    float py = I->mouse.y * k;

    S->mouse.lock = I->mouse.buttons;
    if (S->mouse.lock != 0) {
        float dx = px - S->mouse.x;
        float dy = py - S->mouse.y;

        vec3 move = {{-dx, dy, 0.0f}};
        S->cam = mat4_moved (& S->cam, & move);
    }

    S->mouse.x = px;
    S->mouse.y = py;

    S->show_normals ^= I->toggle_normals;
    S->show_wireframe ^= I->toggle_wireframe;

    if (I->next_turn && !S->turn_transition) {
        S->turn_transition = 1;
        S->turn_transition_ends = E->time + k_turn_transition_delay;
    }

    if (S->turn_transition && E->time > S->turn_transition_ends) {
        S->turn++;
        S->turn_transition = 0;
    }
}

