void logshader (GLuint sh) {
    GLint size = 0;
    glGetShaderiv (sh, GL_INFO_LOG_LENGTH, &size);
    if (size > 0) {
        char * log = (char *) malloc ((size_t) size);
        assert (log != NULL);

        glGetShaderInfoLog (sh, size, NULL, log);
        fprintf (stderr, "%s\n", log);
        free (log);
    }
}

