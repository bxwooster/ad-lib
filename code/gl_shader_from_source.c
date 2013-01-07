GLuint
gl_shader_from_source (
        char const * pieces [],
        unsigned count,
        GLenum type
) {
    GLuint shader = GL_FALSE;
    GLint code = GL_FALSE;
    shader = glCreateShader (type);
    
    unsigned const P = 2;
    size_t memsize = (count + P) * sizeof (char *);
    char const * * all_pieces = alloca (memsize);
    memcpy (all_pieces + P, pieces, memsize);
    all_pieces[0] = gl_shader_preamble ();
    all_pieces[1] = (type == GL_VERTEX_SHADER) ?
        "#define VS\n" : "#define FS\n";
    glShaderSource (shader, count + P, all_pieces, NULL);
    glCompileShader (shader);
    glGetShaderiv (shader, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE || 1) {
        log_info("Shader source:\n");
        for (unsigned i = 0; i < count; i++)
            log_info ("// piece %d:\n%s", i, pieces[i]);
        gl_shader_log (shader);
        glDeleteShader (shader);
        shader = GL_FALSE;
    }

    return shader;
}

