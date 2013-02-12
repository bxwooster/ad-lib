struct GLvbo_and_size {
    GLuint vbo;
    GLsizei size;
};

struct planetlistA_element {
	struct planetA planet;
	char * file;
    struct {
        struct planetlistA_element *next;	/* next element */
        struct planetlistA_element **prev; /* address of previous next (sic) element */
    } _;
};

struct planetlistA_head {
    struct planetlistA_element *first; /* first element */
    struct planetlistA_element **last; /* addr of last next (?? -- ED) element */
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

struct galaxy_helper {
    mat4 transform;
    float size;
};

struct planet_DD {
    mat4 mvp;
    mat4 mv;
    float depth;
    float uvscale;
    GLuint texture;
    vec3 colour;
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

struct GL {
    int ready;
    SDL_GLContext context;
    GLsizei vertices; // this needs explanation
};

struct SDL {
    int ready;
    SDL_Window * window;
    int subsystem_video;
    int subsystem_timer;
};

struct stone_engine {
    mat4 const * mproj;
    unsigned width;
    unsigned height;
    float screen_size;
    struct GLvbo_and_size * imposter;
    struct planetlistA_head const * planet_list;
    unsigned planetA_count;
    struct planetB * galaxy;
    struct galaxy_helper * gh;
    unsigned galaxy_size;
    struct planet_DD * planet_memory;
    struct glts_planeta const * glts;
    struct GL * gl;
    struct SDL * sdl;
};
