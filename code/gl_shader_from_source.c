GLuint
gl_shader_from_source (
        char const * source,
        GLenum type
) {
    long size = -1;
    FILE * fp = NULL;
    char * src = NULL;
    GLuint sh = GL_FALSE;

    char const * file = source; //temporary hack

    if (
        (fp = fopen (file, "rb")) == 0 ||
        fseek (fp, 0L, SEEK_END) != 0 ||
        (size = ftell (fp)) < 0 ||
        fseek (fp, 0L, SEEK_SET) != 0 ||
        (src = (char *) malloc ((size_t) size + 1)) == NULL ||
        fread(src, 1, (size_t) size, fp) != (size_t) size
    ) {
        goto end;
    }

    src[size] = '\0';

    GLint code = GL_FALSE;
    sh = glCreateShader (type);
    
    char const * srcs [] = {gl_shader_preamble (), src};
    glShaderSource (sh, 2, srcs, NULL);
    glCompileShader (sh);
    glGetShaderiv (sh, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE) {
        GLint size = 0;
        glGetShaderiv (sh, GL_INFO_LOG_LENGTH, &size);
        char * log;
        if (size > 0) {
            log = malloc (size);
            if (log) {
                glGetShaderInfoLog (sh, size, NULL, log);
                log_info ("%s", log);
                free (log);
            } else {
                log_info ("No memory to display shader log!");
            }
        } else {
            log_info ("No shader log available.");
        }
        goto end;
    }

    end:

    if (fp != NULL) {
        fclose (fp);
    }
    free (src);

    return sh;
}

