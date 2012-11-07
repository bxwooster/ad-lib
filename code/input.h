struct input {
    int halt;
    int toggle_wireframe;
    int toggle_normals;
    struct {
        int x, y;
        uint8_t buttons;
    } mouse;
};

