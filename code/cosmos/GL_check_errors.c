int
GL_check_errors (
        struct GL * gl
) {
    (void) gl;
    GLuint error = glGetError ();
    if (error != 0) {
        log_info ("There occurred a GL error, # %d.", error);
    }

    return (error != 0);
}
