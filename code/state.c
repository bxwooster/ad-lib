float const k_camera_speed = 0.05f;
float const k_turn_transition_delay = 1.5f;

struct framestate * state_init (struct stone_engine * E) {
    struct framestate * S = malloc (sizeof (*E->S));
    OK (S != NULL);
    *S = (struct framestate) {0};

    float fov = 60.0f;
    S->proj = util_projection (E->sdl->width, E->sdl->height, fov);

    mat4 one = mat4_identity ();

    vec3 move = {{0.0f, 1.7f, 1.0f}};
    S->mov = mat4_moved (& one, & move);
    
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    float angle = M_PI * 0.7;
    S->rot = mat4_rotated_aa (& one, & axis, angle);

    S->show_normals = 1;
    S->time = 0.0;

    return S;
}

void state_del (struct framestate * S) {
    free (S);
}

void state_poll_input (struct stone_engine * E, struct inputstate * I) {
    memset (I, 0, sizeof (*I));

    int x, y;
    I->mouse.buttons = SDL_GetMouseState (& x, & y);

    float hw = E->sdl->width / 2;
    float hh = E->sdl->height / 2;

    I->mouse.x = (x - hw) / hw;
    I->mouse.y = (y - hh) / hw;

    SDL_Event event;
    while (SDL_PollEvent (&event)) {
        if (event.type == SDL_KEYDOWN) {
            SDL_Keycode key = event.key.keysym.sym;
            if (key == SDLK_ESCAPE) {
                I->halt = 1;
            }
            else if (key == SDLK_w) {
                I->toggle_wireframe = 1;
            }
            else if (key == SDLK_n) {
                I->toggle_normals = 1;
            }
            else if (key == SDLK_SPACE) {
                I->next_turn = 1;
            }
        } else if (event.type == SDL_QUIT) {
            I->halt = 1;
        }
    }

    Uint8 * keys = SDL_GetKeyboardState (NULL);

    I->arrows.up = keys[SDL_SCANCODE_UP];
    I->arrows.down = keys[SDL_SCANCODE_DOWN];
    I->arrows.left = keys[SDL_SCANCODE_LEFT];
    I->arrows.right = keys[SDL_SCANCODE_RIGHT];
}

void state_advance (struct framestate * S, struct inputstate const * I) {
    S->time = (double) SDL_GetTicks () / 1000;

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

    float q = 1.0f / tanf (M_PI / 180 / 2 * 60.0);
    vec4 view = {-I->mouse.x / q, I->mouse.y / q, 1.0, 0.0};
    mat4 invrot = mat4_inverted_rtonly (& S->rot);
    /* need this be inverted? */
    view = vec4_multiply (& invrot, & view);

    float ratio = S->mov.column.w.element.z / view.element.z;
    float px = view.element.x * ratio + S->mov.column.w.element.x;
    float py = view.element.y * ratio + S->mov.column.w.element.y;

    char lock = (I->mouse.buttons & SDL_BUTTON (1)) != 0;

    float delta = k_camera_speed;
    // note: need to multiply by Dt, actually
    if (I->arrows.up) S->mov.column.w.element.y -= delta;
    if (I->arrows.down) S->mov.column.w.element.y += delta;
    if (I->arrows.left) S->mov.column.w.element.x -= delta;
    if (I->arrows.right) S->mov.column.w.element.x += delta;

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

    S->show_normals ^= I->toggle_normals;
    S->show_wireframe ^= I->toggle_wireframe;

    if (I->next_turn && !S->turn_transition) {
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
