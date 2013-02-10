void
sIII (
        mat4 const * mproj,
        unsigned width, unsigned height,
        float screen_size,
        struct GLvbo_and_size * imposter,
        struct planetlistA_head const * planet_list,
        unsigned planetA_count,
        struct planetB * galaxy,
        struct galaxy_helper * gh,
        unsigned galaxy_size,
        struct planet_DD * planet_memory,
        struct cosmosA_glts const glts [3],
        struct GL * gl,
        struct SDL * sdl
)
/* ... where all sorts of states enter the scene */
{
    unsigned long frame = 0;
    struct framestate state = initial_framestate ();
    to_common_draw_GLstate (gl, width, height, imposter);

    for (;;) {
        if (were_there_any_GL_errors (gl)) break;

        double time = (double) SDL_GetTicks () / 1000;

        struct input physical = poll_SDLevents (sdl);
        if (physical.halt) break;

        advance_framestate (& state, screen_size, & physical, time);

        struct frame_DD framedata =
            generate_frame_DD (mproj, & state);

        moduleA (time, planet_list, & framedata, planet_memory);

        moduleB (time, & state, galaxy, gh, galaxy_size,
               & framedata, planet_memory, planetA_count);

        moduleP (& state, planet_memory, planetA_count + galaxy_size, gl, glts);

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

