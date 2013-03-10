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

vec3 screenray (vec2 const * pointer) {
    float q = 1.0f / tanf (M_PI / 180 * k_fov / 2);
    vec4 screen = {pointer->e.x / q, -pointer->e.y / q, 1.0, 0.0};
    return vec4_multiply (& XE->S->viewi, & screen).v3;
}

vec3 intersection (vec3 const * C, vec3 const * V,
        vec3 const * N, vec3 const * P) {
    vec3 CmP = vec3_diff (C, P);
    float ratio = -vec3_dot (N, & CmP) / vec3_dot (N, V);
    vec3 Vr = vec3_scaled (V, ratio);
    return vec3_sum (C, & Vr);
}
void state_advance (struct stone_engine * E) {
    struct framestate * S = E->S;

    double time = (double) SDL_GetTicks () / 1000;
    S->dt = time - S->time;
    S->time = time;

    S->pointer = Pointer ();

    S->viewi = mat4_multiply (& S->mov, & S->rot);
    mat4 mview = mat4_inverted_rtonly (& S->viewi);
    S->viewproj = mat4_multiply (& S->proj, & mview);

    vec3 V = screenray (& S->pointer);
    vec3 C = S->viewi.c.w.v3;
    vec3 N = (vec3) {0,0,1};
    vec3 P = (vec3) {0,0,0};

    vec2 I = intersection (& C, & V, & N, & P).v2;

    uint8_t mouse_butt = SDL_GetMouseState (NULL, NULL);
    char locked = (mouse_butt & SDL_BUTTON (1)) != 0;

    if (S->lock != 0) {
        vec2 D = vec2_diff (& I, & S->intersection);

        S->mov.c.w.e.x -= D.e.x;
        S->mov.c.w.e.y -= D.e.y;

        if (!locked) S->lock = 0;
    }
    else {
        if (locked) {
            S->lock = 1;
            S->intersection = I;
            logi ("Locked @ %f - %f", I.p[0], I.p[1]);
        }
    }

    // end of useful code
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
}
