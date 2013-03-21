typedef void * SDL_GLContext;
typedef struct SDL_Window SDL_Window;
struct SDL {
    SDL_GLContext GLcontext;
    SDL_Window * window;
    unsigned width;
    unsigned height;
};
