#if defined VS
in vec2 Apos2d;

void main(void) {
    gl_Position = vec4 (-1.0 + 2 * Apos2d, 0.0, 1.0);
}
#endif
