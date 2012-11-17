struct planet_shader
load_planet_shader (
        struct GL * gl,
        char const * vs_filename,
        char const * fs_filename
) {
    GLuint vs = GL_FALSE;
    GLuint fs = GL_FALSE;
    GLuint program = GL_FALSE;

    do {
        char * vs_source = load_file (vs_filename);
        if (vs_source == NULL) break;

        vs = gl_shader_from_source (vs_source, GL_VERTEX_SHADER);
        if (vs == GL_FALSE)
            log_info ("That happened while loading %s just now.", vs_filename);

        free (vs_source);

        char * fs_source = load_file (fs_filename);
        if (fs_source == NULL) break;

        fs = gl_shader_from_source (fs_source, GL_FRAGMENT_SHADER);
        if (fs == GL_FALSE)
            log_info ("That happened while loading %s just now.", fs_filename);

        free (fs_source);

        program = link_GLprogram (vs, fs, gl);

    } while (0);

    glDeleteShader (vs);
    glDeleteShader (fs);

    struct planet_layout layout;
    layout.mv = glGetUniformLocation (program, "I.mv");
    layout.mvp = glGetUniformLocation (program, "I.mvp");
    layout.colour = glGetUniformLocation (program, "I.colour");
    layout.depth = glGetUniformLocation (program, "I.depth");
    layout.uvscale = glGetUniformLocation (program, "I.uvscale");
    layout.texture = glGetUniformLocation (program, "I.texture");

    /*if (... == -1) {
        log_info ("While loading\n\t%s,\n\t%s,\nthe uniform ... was not found.",
                vs_filename,
                fs_filename
        );
    }*/

    return (struct planet_shader) {program, layout};
}
