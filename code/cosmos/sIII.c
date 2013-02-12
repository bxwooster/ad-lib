void
sIII (
        struct stone_engine * E
)
/* ... where all sorts of states enter the scene */
{
    unsigned long frame = 0;
    struct framestate state = initial_framestate ();
    to_common_draw_GLstate (E->gl, E->width, E->height);

    for (;;) {
        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        #ifndef GLES
            GLenum poly_mode = state.show_wireframe ? GL_LINE : GL_FILL;
            glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
        #endif

        if (GL_check_errors (E->gl)) break;

        double time = (double) SDL_GetTicks () / 1000;

        struct input physical = poll_SDLevents (E->sdl);
        if (physical.halt) break;

        advance_framestate (& state, E->screen_size, & physical, time);

        struct frame_DD framedata =
            generate_frame_DD (E->mproj, & state);

        moduleA (time, E->planet_list, & framedata, E->planet_memory);

        moduleB (time, & state, E->galaxy, E->gh, E->galaxy_size,
               & framedata, E->planet_memory, E->planetA_count);

        moduleP (& state, E->planet_memory, E->planetA_count + E->galaxy_size, E->gl, E->imposter, E->glts);

        SDL_GL_SwapWindow (E->sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

