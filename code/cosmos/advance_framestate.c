void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

    /* this is all broken at the moment */
    mat4 camrot = S->cam;
    camrot.column.w = (vec4) {{0, 0, 0, 1}};

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {I->mouse.x / q, I->mouse.y / q, 1.0, 0.0};

    vec4 result = vec4_multiply (& camrot, & view);
    log_debug ("R = %f, %f, %f, %f",
            result.p[0], result.p[1], result.p[2], result.p[3]);

    float ratio  = S->cam.column.w.element.z / result.element.z;
    float px = result.element.x * ratio;
    float py = result.element.y * ratio;

    if (I->mouse.buttons != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        if (0 && I->mouse.buttons & SDL_BUTTON_LEFT) {
            vec3 move = {{-dx, -dy, 0.0f}};
            S->cam = mat4_moved (& S->cam, & move);
        }

        if (I->mouse.buttons & SDL_BUTTON_RIGHT) {
            vec3 rot = {{dy, dx, 0.0f}};
            float angle = sqrtf (dx*dx + dy*dy)/ 4.0f;
            if (angle > 0) {
                S->cam = mat4_rotated_aa (& S->cam, & rot, angle);
            }
        }
    }

    S->pan.x = px;
    S->pan.y = py;

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

