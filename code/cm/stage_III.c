void
stage_III (
        mat4 const * mproj,
        float screen_size,
        float vertices,
        struct planethead const * planetlist,
        GLint const uniform_depth,
        GLint const uniform_mvp,
        GLint const uniform_mv,
        GLint const uniform_color,
        GLint const uniform_uvscale,
        GLint const uniform_texture,
        struct GL * gl,
        struct SDL * sdl
) {
    (void) gl;

    mat4 mcam = mat4_identity ();
    vec3 axis_x = {{1.0f, 0.0f, 0.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_x, pi () / 2.4f);
    vec3 move = {{0.0f, 0.0f, -13.0f}};
    mcam = mat4_moved (& mcam, & move);
    vec3 axis_z = {{0.0f, 0.0f, 1.0f}};
    mcam = mat4_rotated_aa (& mcam, & axis_z, pi ());

    mat4 mori = mat4_identity ();

    float x = 0;
    float y = 0;
    int mouselock = 0;
    unsigned long frame = 0;
    for (;;) {
        GLuint glerror = glGetError ();
        if (glerror != 0) {
            log_info ("Frame %d: GL error # %d.", frame, glerror);
            break;
        }

        SDL_Event evt;
        if (SDL_PollEvent (&evt)) {
            if (evt.type == SDL_KEYDOWN) {
                SDL_Keycode key = evt.key.keysym.sym;
                if (key == SDLK_ESCAPE) {
                    break;
                }
            } else if (evt.type == SDL_QUIT) {
                break;
            }
        }

        int ix, iy;
        Uint8 mousebuttons = SDL_GetMouseState (&ix, &iy);

        float nx = ix / screen_size;
        float ny = iy / screen_size;
        float dx;
        float dy;
        if (mouselock != 0) {
            dx = x - nx;
            dy = y - ny;
        } else {
            dx = 0;
            dy = 0;
        }
        x = nx;
        y = ny;

        mouselock = mousebuttons;

        float const ROTATION_SPEED = 4.0f;
        float angle = sqrtf (dx * dx + dy * dy) * ROTATION_SPEED;
        vec3 axis = {{dy, 0.0f, dx}};

        if (angle != 0.0f) mori = mat4_rotated_aa (& mori, & axis, angle);

        double time = (double) SDL_GetTicks () / 1000;

        glClearColor (0.0, 0.0, 0.0, 0.0);
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        mat4 mviewi = mat4_multiply (& mori, & mcam);
        mat4 mview = mat4_inverted_rtonly (& mviewi);
        mat4 mviewproj = mat4_multiply (mproj, & mview);

        struct sysplanet * item;
        TAILQ_FOREACH(item, planetlist, _) {
            float tosurface;
            float apparentratio;
            mat4 mrot;
            mat4 mmodel;

            struct planet const * planet = &item->planet;

            float phi = (float)
                ((time / planet->orbit.period) * pi () * 2.0);

            mmodel = planet->orbit.matrix;
            mmodel.column.w.element.x +=
                planet->orbit.major * cosf (phi);
            mmodel.column.w.element.y +=
                planet->orbit.minor * sinf (phi);

            vec3 first = vec3_diff (
                & mmodel.column.w.v3,
                & mviewi.column.w.v3);

            float p = vec3_length (& first);
            float r = planet->size;
            float apparent = sqrtf (p * p - r * r) * r / p;
            float offset = (r * r) / p;

            vec3 unit_x = {{1.0f, 0.0f, 0.0f}};
            vec3 unit_y = {{0.0f, 1.0f, 0.0f}};

            vec3 second;

            if (first.element.x < first.element.y) {
                second = vec3_product (& first, & unit_x);
            } else {
                second = vec3_product (& first, & unit_y);
            }

            vec3 third = vec3_product (& first, & second);

            first = vec3_normalized (& first);
            second = vec3_normalized (& second);
            third = vec3_normalized (& third);

            mat4 rotation = {{0}};
            rotation.column.z.v3 = first;
            rotation.column.x.v3 = second;
            rotation.column.y.v3 = third;
            rotation.p[15] = 1.0f;
            mmodel = mat4_multiply (& mmodel, & rotation);

            mrot = mmodel;
            mrot.p[12] = mrot.p[13] = mrot.p[14] = 0.0f;

            vec3 move = {{0.0f, 0.0f, -offset}};
            mmodel = mat4_moved (& mmodel, & move);
            mmodel = mat4_scaled (& mmodel, apparent);

            tosurface = p - r;
            apparentratio = apparent / r;
            //
            mat4 matrix = mat4_multiply (& mviewproj, & mmodel);

            glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix.p);
            glUniformMatrix4fv (uniform_mv, 1, GL_FALSE, mrot.p);

            float const hack = logf (tosurface) / 1000.0f;
            glUniform1f (uniform_depth, hack);
            glUniform1f (uniform_uvscale, apparentratio);
            glUniform1i (uniform_texture, 0);
            glUniform3fv (uniform_color, 1, item->planet.color);

            glDrawArrays (GL_TRIANGLES, 0, vertices);
        }
 
        SDL_GL_SwapWindow (sdl->window);
        frame++;
    }

    log_info ("%d frames were done. Have a nice day!", frame);
}
