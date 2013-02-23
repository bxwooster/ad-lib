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

struct GL init_GL (struct SDL const * sdl);

struct IMG init_IMG (void);

struct SDL init_SDL (void);

void exit_GL (struct GL * gl, struct SDL * sdl);

void exit_IMG (struct IMG * img);

void exit_SDL (struct SDL * sdl);
