void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

    S->mouse.lock = I->mouse.buttons;
    if (S->mouse.lock != 0) {
        float dx = I->mouse.x - S->mouse.x;
        float dy = I->mouse.y - S->mouse.y;
        
        vec3 move = {{dx * k_mouse_sensitivity, -dy * k_mouse_sensitivity, 0.0f}};
        S->ori = mat4_moved (& S->ori, & move);
    }

    S->mouse.x = I->mouse.x;
    S->mouse.y = I->mouse.y;

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

