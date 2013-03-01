struct GL {
    SDL_GLContext context;
    GLsizei vertices; // this needs explanation
};

struct SDL {
    SDL_Window * window;
    unsigned width;
    unsigned height;
};
