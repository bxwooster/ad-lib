struct GLvbo_and_size
prepare_GLvbo (
        struct GL * gl
) {
    float const y = (float) (1.0 - sqrt(2.0));

    struct {
        float x;
        float y;
    } const tris [] [3] = {
        {{0, 0}, {+1,-y}, {+1,+y}},
        {{0, 0}, {+1,+y}, {-y,-1}},
        {{0, 0}, {-y,-1}, {+y,-1}},
        {{0, 0}, {+y,-1}, {-1,+y}},
        {{0, 0}, {-1,+y}, {-1,-y}},
        {{0, 0}, {-1,-y}, {+y,+1}},
        {{0, 0}, {+y,+1}, {-y,+1}},
        {{0, 0}, {-y,+1}, {+1,-y}},
    };
    int vertices = sizeof (tris) / sizeof (tris[0][0]);

    (void) gl;
    GLuint vbo;
    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    return (struct GLvbo_and_size) {vbo, vertices};
}

