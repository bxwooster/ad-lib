float const k_fov = 60.0f;
float const k_camera_speed = 2.0f;
float const k_turn_transition_delay = 1.5f;

struct framestate * state_init (struct stone_engine * E) {
    struct framestate * S = malloc (sizeof (*E->S));
    OK (S != NULL);
    *S = (struct framestate) {0};

    S->proj = util_projection (E->sdl->width, E->sdl->height, k_fov);

    mat4 one = mat4_identity ();

    vec3 move = {{0.0f, 1.7f, 1.0f}};
    S->mov = mat4_moved (& one, & move);

    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    float angle = M_PI * 0.7;
    S->rot = mat4_rotated_aa (& one, & axis, angle);

    S->time = 0.0;

    return S;
}

void state_del (struct framestate * S) {
    free (S);
}

API vec2 Pointer () {
    int x, y;
    SDL_GetMouseState (& x, & y);

    float hw = XE->sdl->width / 2;
    float hh = XE->sdl->height / 2;

    float mx = (x - hw) / hw;
    float my = (y - hh) / hw;
    
    return (vec2) {mx, my};
}

void state_advance (struct stone_engine * E) {
    struct framestate * S = E->S;

    double time = (double) SDL_GetTicks () / 1000;
    S->dt = time - S->time;
    S->time = time;

    uint8_t mouse_butt = SDL_GetMouseState (NULL, NULL);
    vec2 m = Pointer ();
    float dx = m.element.x - S->mouse.element.x;
    float dy = m.element.y - S->mouse.element.y;

    /* still, something is broken with arbitrary rotations */
    dx = 0;

    if (mouse_butt & SDL_BUTTON (2)) {
        S->mov.column.w.element.z *= exp(dy);
    }

    if (mouse_butt & SDL_BUTTON (3)) {
        vec3 rot = {{dy, dx, 0.0f}};
        float angle = sqrt (dx*dx + dy*dy);
        if (angle > 0) {
            S->rot = mat4_rotated_aa (& S->rot, & rot, -angle);
        }
    }

    S->mouse = m;

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-m.element.x / q, m.element.y / q, 1.0, 0.0};
    mat4 invrot = mat4_inverted_rtonly (& S->rot);
    /* need this be inverted? */
    view = vec4_multiply (& invrot, & view);

    float ratio = S->mov.column.w.element.z / view.element.z;
    float px = view.element.x * ratio + S->mov.column.w.element.x;
    float py = view.element.y * ratio + S->mov.column.w.element.y;

    char lock = (mouse_butt & SDL_BUTTON (1)) != 0;

    float delta = k_camera_speed * S->dt;
    if (E->keyboard[SDL_SCANCODE_UP] > 0) S->mov.column.w.element.y -= delta;
    if (E->keyboard[SDL_SCANCODE_DOWN] > 0) S->mov.column.w.element.y += delta;
    if (E->keyboard[SDL_SCANCODE_LEFT] > 0) S->mov.column.w.element.x -= delta;
    if (E->keyboard[SDL_SCANCODE_RIGHT] > 0) S->mov.column.w.element.x += delta;

    if (S->lock != 0) {
        float dx = px - S->pan.x;
        float dy = py - S->pan.y;

        S->mov.column.w.element.x -= dx;
        S->mov.column.w.element.y -= dy;

        if (!lock) S->lock = 0;
    }
    else {
        if (lock) {
            S->lock = 1;
            S->pan.x = px;
            S->pan.y = py;

            logi ("Locked @ %f - %f", px, py);
        }
    }

    if (E->keyboard[SDL_SCANCODE_SPACE] == 2 && !S->turn_transition) {
        S->turn_transition = 1;
        S->turn_transition_ends = S->time + k_turn_transition_delay;
    }

    if (S->turn_transition && S->time > S->turn_transition_ends) {
        S->turn++;
        S->turn_transition = 0;
    }

    S->turn_tail = 0.0f;
    if (S->turn_transition) {
        float ttd = k_turn_transition_delay;
        S->turn_tail = (S->time - S->turn_transition_ends + ttd) / ttd;
    }

    S->viewi = mat4_multiply (& S->mov, & S->rot);

    mat4 mview = mat4_inverted_rtonly (& S->viewi);
    S->viewproj = mat4_multiply (& S->proj, & mview);
}
