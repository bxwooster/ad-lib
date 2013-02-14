struct glts_cello
  load_glts_cello (
            struct GL * gl,
            char const * filename
) {
    struct glts_cello it;

    it.program = load_glts (gl, filename, "cello", "");
    // we could check that program's not GL_FALSE, but we won't.
    
    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        log_info ("GL attribute 'Apos2d' not found");
    }

    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    assert (it.Umvp != -1);

    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Ucenter = glGetUniformLocation (it.program, "Ucenter");
    it.Uradius = glGetUniformLocation (it.program, "Uradius");

    return it;
}
