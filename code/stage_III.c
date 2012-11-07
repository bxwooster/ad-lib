void
stage_III (
        mat4 const * mproj,
        unsigned width, unsigned height,
        float screen_size,
        int vertices,
        struct planethead const * planetlist,
        struct planet_draw_GLdata const * GLdata,
        GLuint program,
        struct GL * gl,
        struct SDL * sdl
)
/* ... where all sorts of states enter the scene */
{
    unsigned long frame = 0;
    struct framestate state = initial_framestate ();
    int error = to_common_draw_GLstate (gl, program, width, height);
    if (error) return;

    for (;;) {
        if (were_there_any_GL_errors (gl)) break;

        struct input physical = poll_SDLevents (sdl);
        if (physical.halt) break;

        advance_framestate (
                & state,
                screen_size,
                & physical
        );

        double time = (double) SDL_GetTicks () / 1000;
        struct frame_draw_data framedata = generate_frame_draw_data (
                mproj,
                & state
        );

        to_planet_GLstate (& state, gl);

        struct sysplanet * item;
        TAILQ_FOREACH(item, planetlist, _) {
            struct planet_draw_data data = generate_planet_draw_data (
                    time,
                    & item->planet,
                    & framedata
            );
            planet_draw (vertices, & data, GLdata, gl);
        }

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

