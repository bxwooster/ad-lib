struct planet_GD
planet_GD_from_shader (
        GLuint program,
        struct GL * gl
) {
    (void) gl;

    GLint const uniform_depth = glGetUniformLocation (program, "depth");
    if (uniform_depth == -1) {
        log_info ("GL uniform 'depth' not found");
    }

    GLint const uniform_mvp = glGetUniformLocation (program, "mvp");
    if (uniform_mvp == -1) {
        log_info ("GL uniform 'mvp' not found");
    }

    GLint const uniform_mv = glGetUniformLocation (program, "mv");
    if (uniform_mv == -1) {
        log_info ("GL uniform 'mv' not found");
    }

    GLint const uniform_color = glGetUniformLocation (program, "color");
    if (uniform_color == -1) {
        log_info ("GL uniform 'color' not found");
    }

    GLint const uniform_uvscale = glGetUniformLocation (program, "uvscale");
    if (uniform_uvscale == -1) {
        log_info ("GL uniform 'uvscale' not found");
    }

    GLint const uniform_texture = glGetUniformLocation (program, "texture");
    if (uniform_texture == -1) {
        log_info ("GL uniform 'texture' not found");
    }

    struct planet_GD GLdata = {
        uniform_mvp,
        uniform_mv,
        uniform_depth,
        uniform_uvscale,
        uniform_texture,
        uniform_color
    };

    return GLdata;
}
