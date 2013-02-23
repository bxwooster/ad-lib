/* The Konstants! */
#define k_turn_transition_delay 1.5f
#define k_planet_size_minifier 0.9f
#define k_round_cell_segments 64

#define M_PI 3.14159265358979323846

struct GLvbo_and_size {
    GLuint vbo;
    GLsizei size;
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

struct glts_planeta {
    GLuint program;
    GLuint Apos2d;
    GLint Umv;
    GLint Umvp;
    GLint Ucolour;
    GLint Uuvscale;
    GLint Utexture;
};

struct glts_cello {
    GLuint program;
    GLuint Apos2d;
    GLint Umvp;
    GLint Ucolour;
    GLint Ucutout_center;
    GLint Ucutout_radius;
    GLint Uradius_min;
    GLint Uradius_max;
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

struct stone_engine {
    mat4 const * mproj;
    struct GLvbo_and_size * imposter;
    GLuint cell_vbo;
    struct planetB * galaxy;
    struct galaxy_helper * gh;
    unsigned galaxy_size;
    struct planet_DD * planet_memory;
    struct glts_planeta const * sh_pl;
    struct glts_cello const * sh_ce;
    struct GL * gl;
    struct SDL * sdl;
    struct framestate * state;
    double time;
};
void
advance_framestate (
        struct stone_engine * E,
        struct input const * I
);

void
camera_initial (struct framestate * S);

int closest_planet_DD (void const * a, void const * b);

void
exit_GL (
        struct GL * gl,
        struct SDL * sdl
);

void
exit_IMG (
        struct IMG * img
);

void
exit_SDL (
        struct SDL * sdl
);

struct galaxy_helper
galaxy_prepare (
        struct stone_engine * E,
        unsigned planet_number
);

struct frame_DD
generate_frame_DD (
        mat4 const * proj,
        struct framestate const * S
);

struct planet_DD
generate_planet_DD (
    struct planet_ID const * pid,
    struct frame_DD const * framedata
);

GLuint // tex
get_earth_GLtex (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
);

float
get_fov (void);

GLuint
gl_shader_from_source (
        char const * pieces [],
        unsigned count,
        GLenum type
);

void
gl_shader_log (
        GLuint shader
);

char const *
gl_shader_preamble (void);

void
go_go_go (
        struct stone_engine * E
);

struct GL
init_GL (
        struct SDL const * sdl
);

struct IMG
init_IMG (void);

struct SDL
init_SDL (void);

struct framestate
initial_framestate (void);

GLuint // program
link_GLprogram (
        GLuint vs,
        GLuint fs,
        struct GL * gl
);

GLenum // GLformat
load_earth (
        SDL_Surface * earth [6],
        struct IMG * img,
        struct SDL * sdl
);

char * // contents
load_file (
        char const * filename
);

GLuint // program
load_glts (
            struct GL * gl,
            char const * filename,
            char const * typename,
			char const * typecode
);
struct glts_cello
  load_glts_cello (
            struct GL * gl,
            char const * filename
);
char * // contents
load_glts_file (
        char const * prefix,
        char const * id_starts,
        char const * id_ends_or_null
);
struct glts_planeta
  load_glts_planeta (
            struct GL * gl,
            char const * filename
);

void
moduleB (
        struct stone_engine * E,
        struct frame_DD * framedata
);

void moduleC (
        struct stone_engine * E,
        struct frame_DD * framedata
);

void moduleP (
        struct stone_engine * E
);

int // status
parse_galaxy (
        char const * in,
        struct planetB galaxy [],
        unsigned * count
);

void
poll_SDLevents (
        struct stone_engine * E,
        struct input * currently
);

GLuint // tex
prepare_GLtex (
        SDL_Surface * earth [6],
        GLenum GLformat,
        struct GL * gl
);

struct GLvbo_and_size
prepare_imposter (
        struct GL * gl
);

mat4
projection_from_afn (
		float aspect_ratio,
		float fov_horizontal_in_degrees,
		float near_plane_distance
);

void
sI (void);

void
sII (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
);

mat4 // proj
standard_projection (
        unsigned width,
        unsigned height,
        float fov
);

void
to_common_draw_GLstate (
        struct stone_engine * E
);
