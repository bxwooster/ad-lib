struct glts_planeta
  load_glts_planeta (
            struct GL * gl,
            char const * filename
) {
    struct glts_planeta it;

    it.program = load_glts (gl, filename, "planeta", "");
    // we could check that program's not GL_FALSE, but we won't.
    //
    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        log_info ("GL attribute 'Apos2d' not found");
    }

    it.Umv = glGetUniformLocation (it.program, "Umv");
    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    assert (it.Umvp != -1);

    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Udepth = glGetUniformLocation (it.program, "Udepth");
    it.Uuvscale = glGetUniformLocation (it.program, "Uuvscale");
    it.Utexture = glGetUniformLocation (it.program, "Uexture");
    // ignore some missing uniforms
    return it;
}
