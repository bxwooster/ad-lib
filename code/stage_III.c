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

    unsigned count = 0;
    for (struct sysplanet *
            item = TAILQ_FIRST(planetlist);
            item != TAILQ_END(planetlist);
            item = TAILQ_NEXT(item, _)) {
        count++;
    }

    struct planet_draw_data * datas =
        malloc (count * sizeof (struct planet_draw_data));

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

        unsigned i = 0;
	    for (struct sysplanet *
                item = TAILQ_FIRST(planetlist);
                item != TAILQ_END(planetlist);
                item = TAILQ_NEXT(item, _)) {
            datas[i] = generate_planet_draw_data (
                    time,
                    & item->planet,
                    & framedata
            );
            i++;
        }

        for (unsigned i = 0; i < count; ++i) {
            planet_draw (vertices, datas + i, GLdata, gl);
        }

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    free (datas);

    log_info ("%d frames were done. Have a nice day!", frame);
}

