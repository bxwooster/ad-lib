void
stage_III (
        mat4 const * mproj,
        float screen_size,
        int vertices,
        struct planethead const * planetlist,
        struct planet_draw_GLdata const * GLdata,
        struct GL * gl,
        struct SDL * sdl
) {
    unsigned long frame = 0;
    struct framestate state = initial_framestate ();

    for (;;) {
        GLuint glerror = glGetError ();
        if (glerror != 0) {
            log_info ("Frame %d: GL error # %d.", frame, glerror);
            break;
        }

        int quit = poll_SDLevents (sdl);
        if (quit) break;

        int ix, iy;
        uint8_t mousebuttons = SDL_GetMouseState (&ix, &iy);

        advance_framestate (
                & state,
                screen_size,
                ix, iy,
                mousebuttons
        );

        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        double time = (double) SDL_GetTicks () / 1000;
        struct frame_draw_data framedata = generate_frame_draw_data (
                mproj,
                & state
        );

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

