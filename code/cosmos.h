int
GL_check_errors (
        struct GL * gl
);
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
        double time,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct framestate const * state
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
int // exitcode
main (
        int argc,
        char * argv []
)
/* Entry point. Handles the command-line arguments and proceeds. */
 ;
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
planet_ID_from_B (
        double time,
        struct planet_ID * out,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct frame_DD const * framedata
);
mat4
planet_dayrotation (
        struct planet_day const * day,
        double time
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
sI (void)
/* ... where libraries are initalized and put to good use. */
 ;
void
sII (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
)
 ;
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

