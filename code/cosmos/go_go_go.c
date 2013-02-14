void
go_go_go (
        struct stone_engine * E
)
{
    unsigned long frame = 0;
    to_common_draw_GLstate (E);

    for (;;) {
        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        #ifndef GLES
            GLenum poly_mode = E->state->show_wireframe ? GL_LINE : GL_FILL;
            glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
        #endif

        //if (GL_check_errors (E->gl)) break;

        E->time = (double) SDL_GetTicks () / 1000;

        struct input physical;
        poll_SDLevents (E, & physical);
        if (physical.halt) break;

        advance_framestate (E, & physical);

        struct frame_DD framedata =
            generate_frame_DD (E->mproj, E->state);

        moduleB (E, & framedata);
        moduleP (E);
        moduleC (E, & framedata);

        SDL_GL_SwapWindow (E->sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}

