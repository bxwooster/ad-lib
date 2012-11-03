GLuint // vbo
prepare_GLvbo (
        struct GL * gl
) {
    struct {
        float x;
        float y;
    } const tris [] = {
        {-1.0,-1.0},
        { 1.0,-1.0},
        {-1.0, 1.0},
        {-1.0, 1.0},
        { 1.0,-1.0},
        { 1.0, 1.0}
    };
    //int vertices = sizeof (tris) / sizeof (tris[0]);

    (void) gl;
    GLuint vbo;
    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo); // this is a bit wrong
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    return vbo;
}

