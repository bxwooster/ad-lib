void
stage_III (
        mat4 const * mproj,
        unsigned width, unsigned height,
        float screen_size,
        struct GLvbo_and_size * imposter,
        struct planetlistA_head const * planet_list,
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

        struct input physical = poll_SDLevents (sdl);
        if (physical.halt) break;

        advance_framestate (
                & state,
                screen_size,
                & physical
        );

        struct frame_DD framedata = generate_frame_DD (
                sdl, 
                mproj,
                & state
        );

        struct cosmosA_layout const * layout = to_planet_GLstate (
                & state,
                gl,
                glts
        );

        unsigned j = 0;
	    for (struct planetlistA_element *
                item = planet_list->first;
                item != NULL;
                item = item->_.next
        ) {
            struct planet_ID pid;
            planet_ID_from_A (& pid, & item->planet, & framedata);
            planet_memory[j] = generate_planet_DD (
                    & pid,
                    & framedata
            );
            j++;
        }

        for (unsigned i = 0; i < galaxy_size; ++i) {
            gh[i] = galaxy_prepare (galaxy, gh, i);
        }

        for (unsigned i = 0; i < galaxy_size; ++i) {
            struct planet_ID pid;
            planet_ID_from_B (
                    & pid,
                    galaxy,
                    gh,
                    i,
                    & framedata
            );
            planet_memory[j] = generate_planet_DD (
                    & pid,
                    & framedata
            );
            j++;
        }

        qsort (planet_memory, j, sizeof (struct planet_DD), closest_planet_DD);

        for (unsigned i = 0; i < j; ++i) {
            planet_draw (planet_memory + i, layout, gl);
        }

        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

