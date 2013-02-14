void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

    if (I->mouse.buttons & SDL_BUTTON(3)) {
        float dx = I->mouse.x - S->mouse.x;
        float dy = I->mouse.y - S->mouse.y;
        /* still something is broken with arbitrary rotations */
        dx = 0;

        vec3 rot = {{dy, dx, 0.0f}};
        float angle = sqrt (dx*dx + dy*dy);
        if (angle > 0) {
            S->cam = mat4_rotated_aa (& S->cam, & rot, -angle);
        }
    }

    S->mouse.x = I->mouse.x;
    S->mouse.y = I->mouse.y;

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-I->mouse.x / q, -I->mouse.y / q, 1.0, 0.0};
    view = vec4_multiply (& S->cam, & view);

    float ratio  = S->cam.column.w.element.z / view.element.z;
    float px = view.element.x * ratio;
    float py = view.element.y * ratio;

    if (S->lock != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        S->cam.column.w.element.x -= dx;
        S->cam.column.w.element.y += dy;
    }

    S->pan.x = px;
    S->pan.y = py;

    S->lock = (I->mouse.buttons != 0);

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

