struct planeta_glts
  load_planeta_glts (
            struct GL * gl,
            char const * filename
) {
    struct planeta_glts it;

    it.program = load_glts (gl, filename, "planeta", "");
    // we could check that program's not GL_FALSE, but we won't.
    //
    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        log_info ("GL attribute 'Apos2d' not found");
    }

    it.layout.Umv = glGetUniformLocation (it.program, "Umv");
    it.layout.Umvp = glGetUniformLocation (it.program, "Umvp");
    assert (it.layout.Umvp != -1);
    assert (it.layout.Umv != -1);

    it.layout.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.layout.Udepth = glGetUniformLocation (it.program, "Udepth");
    it.layout.Uuvscale = glGetUniformLocation (it.program, "Uuvscale");
    it.layout.Utexture = glGetUniformLocation (it.program, "Uexture");
    // ignore some missing uniforms
    return it;
}
