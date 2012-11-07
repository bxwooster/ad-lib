int
were_there_any_GL_errors (
        struct GL * gl
) {
    (void) gl;
    GLuint error = glGetError ();
    if (error != 0) {
        log_info ("There occurred a GL error, # %d.", error);
    }

    return (error != 0);
}
