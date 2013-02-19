void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
) {
    struct framestate * S = E->state;

    float dx = I->mouse.x - S->mouse.x;
    float dy = I->mouse.y - S->mouse.y;
    /* still something is broken with arbitrary rotations */
    dx = 0;

    if (I->mouse.buttons & SDL_BUTTON (2)) {
        S->mov.column.w.element.z *= exp(dy);
    }
    
    if (I->mouse.buttons & SDL_BUTTON (3)) {
        vec3 rot = {{dy, dx, 0.0f}};
        float angle = sqrt (dx*dx + dy*dy);
        if (angle > 0) {
            S->rot = mat4_rotated_aa (& S->rot, & rot, -angle);
        }
    }

    S->mouse.x = I->mouse.x;
    S->mouse.y = I->mouse.y;

    mat4 cam = mat4_multiply (& S->mov, & S->rot);

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-I->mouse.x / q, -I->mouse.y / q, 1.0, 0.0};
    view = vec4_multiply (& cam, & view);

    float ratio  = cam.column.w.element.z / view.element.z;
    float px = view.element.x * ratio + cam.column.w.element.x;
    float py = view.element.y * ratio - cam.column.w.element.y;

    char lock = (I->mouse.buttons & SDL_BUTTON (1)) != 0;

    if (S->lock != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        S->mov.column.w.element.x -= dx;
        S->mov.column.w.element.y += dy;

        if (!lock) S->lock = 0;
    }
    else {
        if (lock) {
            S->lock = 1;
            S->pan.x = px;
            S->pan.y = py;

            log_debug ("%f - %f", px, py);
        }
    }

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

