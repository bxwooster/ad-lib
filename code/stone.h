struct framestate {
    mat4 rot;
    mat4 mov;
    struct {
        float x;
        float y;
    } pan;
    struct {
        float x;
        float y;
    } mouse;
    char lock;
    char show_wireframe;
    char show_normals;
    unsigned turn;
    float turn_tail;
    int turn_transition;
    double turn_transition_ends;
};

struct GLvbo_and_size {
    GLuint vbo;
    GLsizei size;
};

struct galaxy {
    struct planet * planets;
    unsigned size;
};

struct stone_engine {
    mat4 mproj;
    struct GLvbo_and_size imposter;
    GLuint cell_vbo;

    struct galaxy * G;
    struct galaxy_helper * gh;
    struct planet_DD * planet_memory;
    struct glts_planeta sh_pl [3];
    struct glts_cello sh_ce;
    GLuint tex;
    struct GL * gl;
    struct SDL * sdl;
    struct framestate state;
    double time;

    struct hot_player * H;
};

struct galaxy_helper {
    mat4 transform;
    float supersize;
    float size;
};

/* Intermediate data, on the way to Draw data */
struct planet_ID {
    mat4 mmodel;
    mat4 mrot;
    float size;
    vec3 colour;
};

struct planet_DD {
    mat4 mvp;
    mat4 mv;
    float depth;
    float uvscale;
    GLuint texture;
    vec3 colour;
};

struct frame_DD { // atrocious name
    mat4 viewi;
    mat4 viewproj;
};

struct input {
    char halt;
    char toggle_wireframe;
    char toggle_normals;
    char next_turn;
    struct {
        float x;
        float y;
        uint8_t buttons;
    } mouse;
    struct {
        char up;
        char down;
        char left;
        char right;
    } arrows;
};

