void
gl_shader_log (
        GLuint shader
) {
    GLint size = 0;
    glGetShaderiv (shader, GL_INFO_LOG_LENGTH, &size);
    char * log;
    if (size > 0) {
        log = malloc (size);
        if (log) {
            glGetShaderInfoLog (shader, size, NULL, log);
            log_info ("%s", log);
            free (log);
        } else {
            log_info ("No memory to display shader log!");
        }
    } else {
        log_info ("No shader log available.");
    }
}
