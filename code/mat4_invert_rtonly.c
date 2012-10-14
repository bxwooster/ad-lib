void mat4_invert_rtonly (mat4 * m) {
    float a = m->e [1];
    float b = m->e [2];
    float c = m->e [6];

    m->e [1] = m->e [4];
    m->e [2] = m->e [8];
    m->e [6] = m->e [9];

    m->e [4] = a;
    m->e [8] = b;
    m->e [9] = c;

    float x = -m->e [12];
    float y = -m->e [13];
    float z = -m->e [14];

    m->e [12] = (m->e [0]) * x + (m->e [4]) * y + (m->e [ 8]) * z;
    m->e [13] = (m->e [1]) * x + (m->e [5]) * y + (m->e [ 9]) * z;
    m->e [14] = (m->e [2]) * x + (m->e [6]) * y + (m->e [10]) * z;
}

