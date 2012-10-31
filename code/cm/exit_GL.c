void
exit_GL (
        struct GL * gl,
        struct SDL * sdl
) {
    (void) sdl;

    if (gl->context != NULL) SDL_GL_DeleteContext (gl->context);
    gl->ready = 0;
}

