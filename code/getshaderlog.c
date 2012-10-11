char * getshaderlog (GLuint valid_shader, struct mem * ory) {
    GLint size = 0;
    glGetShaderiv (valid_shader, GL_INFO_LOG_LENGTH, &size);
    char * log;
    if (size > 0) {
        log = cutmem (ory, size, 1);
        if (log) {
            glGetShaderInfoLog (valid_shader, size, NULL, log);
        } else {
            log = "No memory to display shader log.";
        }
    } else {
        log = "No shader log available.";
    }
    return log;
}

