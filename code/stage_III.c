void
stage_III (
        mat4 const * mproj,
        unsigned width, unsigned height,
        float screen_size,
        struct GLvbo_and_size * imposter,
        struct planethead const * planet_list,
        struct planet_DD * planet_memory,
        struct planet_GD const * GLdata,
        GLuint program,
        struct GL * gl,
        struct SDL * sdl
)
/* ... where all sorts of states enter the scene */
{
    unsigned long frame = 0;
    struct framestate state = initial_framestate ();
    int error = to_common_draw_GLstate (gl, program, width, height, imposter);
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
        struct frame_DD framedata = generate_frame_DD (
                mproj,
                & state
        );

        to_planet_GLstate (& state, gl);

        unsigned j = 0;
	    for (struct sysplanet *
                item = planet_list->first;
                item != NULL;
                item = item->_.next) {
            planet_memory[j] = generate_planet_DD (
                    time,
                    & item->planet,
                    & framedata
            );
            j++;
        }

        qsort (planet_memory, j, sizeof (struct planet_DD), closest_planet_DD);

        for (unsigned i = 0; i < j; ++i) {
            planet_draw (planet_memory + i, GLdata, gl);
        }

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

