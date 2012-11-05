GLuint
gl_shader_from_source (
        char const * source,
        GLenum type
) {
    GLuint shader = GL_FALSE;
    GLint code = GL_FALSE;
    shader = glCreateShader (type);
    
    char const * pieces [] = {gl_shader_preamble (), source};
    glShaderSource (shader, 2, pieces, NULL);
    glCompileShader (shader);
    glGetShaderiv (shader, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE) {
        gl_shader_log (shader);
        glDeleteShader (shader);
        shader = GL_FALSE;
    }

    return shader;
}

