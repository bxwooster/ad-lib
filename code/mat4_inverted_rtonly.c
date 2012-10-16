void mat4_invert_rtonly (mat4 * m) {
    float a = m->p[1];
    float b = m->p[2];
    float c = m->p[6];

    m->p[1] = m->p[4];
    m->p[2] = m->p[8];
    m->p[6] = m->p[9];

    m->p[4] = a;
    m->p[8] = b;
    m->p[9] = c;

    float x = -m->p[12];
    float y = -m->p[13];
    float z = -m->p[14];

    m->p[12] = (m->p[0]) * x + (m->p[4]) * y + (m->p[ 8]) * z;
    m->p[13] = (m->p[1]) * x + (m->p[5]) * y + (m->p[ 9]) * z;
    m->p[14] = (m->p[2]) * x + (m->p[6]) * y + (m->p[10]) * z;
}

