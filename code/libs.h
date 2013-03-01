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
