void
stage_III (
        mat4 const * mproj,
        unsigned width, unsigned height,
        float screen_size,
        int vertices,
        struct planethead const * planet_list,
        struct planet_draw_data * planet_memory,
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

        unsigned j = 0;
	    for (struct sysplanet *
                item = TAILQ_FIRST(planet_list);
                item != TAILQ_END(planet_list);
                item = TAILQ_NEXT(item, _)) {
            planet_memory[j] = generate_planet_draw_data (
                    time,
                    & item->planet,
                    & framedata
            );
            j++;
        }

        for (unsigned i = 0; i < j; ++i) {
            planet_draw (vertices, planet_memory + i, GLdata, gl);
        }

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

