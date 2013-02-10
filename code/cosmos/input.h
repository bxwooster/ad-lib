struct input {
    int halt;
    int toggle_wireframe;
    int toggle_normals;
    int next_turn;
    struct {
        int x, y;
        uint8_t buttons;
    } mouse;
};

