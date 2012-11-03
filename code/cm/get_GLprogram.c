GLuint // program
get_GLprogram (
        struct GL * gl
) {
    GLuint vs = GL_FALSE;
    GLuint fs = GL_FALSE;
    GLuint program = GL_FALSE;

    do {
        char * vs_source = load_file ("data/shade/planet.vert");
        if (vs_source == NULL) break;

        vs = gl_shader_from_source (vs_source, GL_VERTEX_SHADER);
        free (vs_source);

        char * fs_source = load_file ("data/shade/planet.frag");
        if (fs_source == NULL) break;

        fs = gl_shader_from_source (fs_source, GL_FRAGMENT_SHADER);
        free (vs_source);

        program = link_GLprogram (vs, fs, gl);

    } while (0);

    glDeleteShader (vs);
    glDeleteShader (fs);

    return program;
}
