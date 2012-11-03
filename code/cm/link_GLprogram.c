GLuint // program
link_GLprogram (
        GLuint vs,
        GLuint fs,
        struct GL * gl
) {
    (void) gl;

    GLuint program = glCreateProgram ();
    glAttachShader (program, vs);
    glAttachShader (program, fs);
    glLinkProgram (program);

    GLint code = GL_FALSE;
    glGetProgramiv (program, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        log_info ("Shader linking failed.");
        glDeleteProgram (program);
        return GL_FALSE;
    }

    return program;
}


