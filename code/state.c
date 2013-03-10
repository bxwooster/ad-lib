float const k_fov = 60.0f;

struct framestate * state_init (struct stone_engine * E) {
    struct framestate * S = malloc (sizeof (*E->S));
    OK (S != NULL);
    *S = (struct framestate) {0};

    S->proj = util_projection (E->sdl->width, E->sdl->height, k_fov);

    return S;
}

void state_del (struct framestate * S) {
    free (S);
}

vec3 ScreenRay (vec2 const * pointer) {
    float q = 1.0f / tanf (M_PI / 180 * k_fov / 2);
    vec4 screen = {pointer->e.x / q, -pointer->e.y / q, 1.0, 0.0};
    return vec4_multiply (& XE->S->viewi, & screen).v3;
}

vec3 PlaneIntersection (vec3 const * C, vec3 const * V,
        vec3 const * N, vec3 const * P) {
    vec3 CmP = vec3_diff (C, P);
    float ratio = -vec3_dot (N, & CmP) / vec3_dot (N, V);
    vec3 Vr = vec3_scaled (V, ratio);
    return vec3_sum (C, & Vr);
}

void state_advance (struct stone_engine * E) {
    struct framestate * S = E->S;

    vec2 pointer = Pointer ();

    vec3 V = ScreenRay (& pointer);
    vec3 C = S->viewi.c.w.v3;
    vec3 N = (vec3) {0,0,1};
    vec3 P = (vec3) {0,0,0};

    vec2 I = PlaneIntersection (& C, & V, & N, & P).v2;

    if (Key (1) == 1) {
        vec2 D = vec2_diff (& I, & S->intersection);
        vec3 D3 = (vec3) {-D.e.x, -D.e.y, 0};
        mat4 mm = mat4_movement (& D3);
        S->viewi = mat4_multiply (& mm, & S->viewi);
    }

    if (Key (1) > 1) {
        S->intersection = I;
        logi ("Locked @ %f - %f", I.p[0], I.p[1]);
    }

    mat4 mview = mat4_inverted_rtonly (& S->viewi);
    S->viewproj = mat4_multiply (& S->proj, & mview);
}
