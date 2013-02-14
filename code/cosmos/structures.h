struct GLvbo_and_size {
    GLuint vbo;
    GLsizei size;
};

struct galaxy_helper {
    mat4 transform;
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

struct glts_planeta {
    GLuint program;
    GLuint Apos2d;
    GLint Umv;
    GLint Umvp;
    GLint Ucolour;
    GLint Udepth;
    GLint Uuvscale;
    GLint Utexture;
};

struct glts_cello {
    GLuint program;
    GLuint Apos2d;
    GLint Umvp;
};

struct GL {
    int ready;
    SDL_GLContext context;
    GLsizei vertices; // this needs explanation
};

struct SDL {
    int ready;
    SDL_Window * window;
    unsigned width;
    unsigned height;
    int subsystem_video;
    int subsystem_timer;
};

struct IMG {
    int ready;
    int type_jpg;
};

struct planet_day {
    vec3 axis;
    float period;
};

struct planetB {
    char name [16];
    struct {
        unsigned parent_index;
        unsigned orbit_number;
        unsigned orbit_slot;
    } where;
    unsigned orbit_count;
	vec3 colour;
    struct planet_day day;
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
};

struct framestate {
    mat4 cam;
    struct {
        float x;
        float y;
    } pan;
    int show_wireframe;
    int show_normals;
    unsigned turn;
    int turn_transition;
    double turn_transition_ends;
};

struct stone_engine {
    mat4 const * mproj;
    struct GLvbo_and_size * imposter;
    struct planetB * galaxy;
    struct galaxy_helper * gh;
    unsigned galaxy_size;
    struct planet_DD * planet_memory;
    struct glts_planeta const * glts;
    struct GL * gl;
    struct SDL * sdl;

    struct framestate * state;
    double time;
};
