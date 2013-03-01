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



struct stone_G1 {
    mat4 transform;
    float supersize;
    float size;
};

struct stone_G2 {
    mat4 mvp;
    mat4 mv;
    float depth;
    float uvscale;
    GLuint texture;
    vec3 colour;
};



struct stone_engine {
    struct hot_player * H;

    struct galaxy * G;
    struct stone_G1 * G1;
    struct stone_G2 * G2;

    GLuint cell_vbo;
    struct GLvbo_and_size imposter;
    struct glts_planeta sh_pl [3];
    struct glts_cello sh_ce;

    GLuint tex;
    mat4 mproj;

    struct GL * gl;
    struct SDL * sdl;

    struct framestate state;
    double time;

    mat4 viewi;
    mat4 viewproj;
};
