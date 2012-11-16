void
to_planet_GLstate (
        struct framestate const * state,
        struct GL * gl
) {
    (void) gl;
#ifndef GLES
    GLenum poly_mode = state->show_wireframe ? GL_LINE : GL_FILL;
    glPolygonMode(GL_FRONT_AND_BACK, poly_mode);
#endif
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
