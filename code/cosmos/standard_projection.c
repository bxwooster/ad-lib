mat4 // proj
standard_projection (
        unsigned width,
        unsigned height,
        float fov
) {
    float const screen_aspect = ((float) width) / height;
    return projection_from_afn (screen_aspect, fov, 0.01f);
}
